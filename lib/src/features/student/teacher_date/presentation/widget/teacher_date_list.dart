import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/schedule_model.dart';
import '../screens/teacher_profile_screen.dart';
import '../view_model/dates_view_model.dart';

class TeacherDatesList extends ConsumerWidget {
  final String teacherId;
  final String language;

  const TeacherDatesList({
    super.key,
    required this.teacherId,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ScheduleFilter(teacherId: teacherId, language: language);
    final schedulesAsync = ref.watch(
      schedulesStreamProvider(
        filter,
      ),
    );

    return schedulesAsync.when(
      data: (schedules) {
        log('The schedules are $schedules');
        if (schedules.isEmpty) {
          return const Center(child: Text("No schedules available"));
        }
        return ListView.builder(
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final schedule = schedules[index];
            return ListTile(
              title: Text(schedule.date),
              subtitle: Text(schedule.teacherName + schedule.language),
              trailing: ElevatedButton(
                child: const Text("Book"),
                onPressed: () {
                  // Navigate to teacher profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TeacherProfileScreen(
                        teacherName: schedule.teacherName,
                        schedule: schedule,
                        // onBook: () {
                        //   final studentName =
                        //       ref.read(authViewModelProvider).user!.name;
                        //   final studentId =
                        //       ref.read(authViewModelProvider).user!.id;
                        //
                        //   ref.read(paymentNotifierProvider.notifier).makePayment(schedule, studentName, studentId);
                        //   // ref
                        //   //     .read(bookingControllerProvider.notifier)
                        //   //     .bookSchedule(schedule, studentName, studentId);
                        // },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, _) => Center(
        child: Text("Error: $err"),
      ),
    );
  }
}
