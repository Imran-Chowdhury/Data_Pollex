import 'package:data_pollex/src/features/video_call/presentation/screens/meeting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/color.dart';
import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../../teacher/booked_lessons/presentation/widget/schedule_card.dart';
import '../view_model/booked_lesson_view_model.dart';

class StudentDateList extends ConsumerWidget {
  const StudentDateList({super.key, required this.language});
  final String language;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentId = ref.read(authViewModelProvider).user!.id;
    final schedulesAsync = ref.watch(bookedSchedulesProvider(
      StudentLanguage(studentId: studentId, language: language),
    ));
    return schedulesAsync.when(
      data: (schedules) {
        if (schedules.isEmpty) {
          return const Center(
            child: Text(
              'No booked schedules.',
              style: TextStyle(color: CustomColor.primary, fontSize: 20),
            ),
          );
        }
        return ListView.builder(
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final schedule = schedules[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoCallPage(
                            scheduleId: schedule.id,
                            userName: schedule.studentName,
                            userId: schedule.studentId,
                          )),
                );
              },
              child: CustomCard(
                subtitle: 'Teacher Name',
                mainText: schedule.date,
                userName: schedule.teacherName,
                userId: schedule.teacherId,
                isBooked: schedule.isBooked,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'Error loading schedules: $e',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
