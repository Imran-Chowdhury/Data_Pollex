import 'dart:developer';

import 'package:data_pollex/src/features/student/teacher_date/presentation/screens/teacher_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/dates_view_model.dart';

class TeacherDatesScreen extends ConsumerWidget {
  final String teacherId;
  final String language;

  const TeacherDatesScreen({
    super.key,
    required this.teacherId,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('The teacherId is $teacherId, the language is $language');
    final filter = ScheduleFilter(teacherId: teacherId, language: language);
    final schedulesAsync = ref.watch(
      schedulesStreamProvider(
        filter,
      ),
    );
    log('The widget is being rebuilt');

    // final bookingState = ref.watch(bookingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Available Dates")),
      body: schedulesAsync.when(
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
                          onBook: () {
                            ref
                                .read(bookingControllerProvider.notifier)
                                .bookSchedule(schedule.id);
                          },
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
      ),
    );
  }
}
