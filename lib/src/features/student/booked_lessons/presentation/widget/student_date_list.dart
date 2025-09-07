import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../../teacher/booked_lessons/presentation/widget/schedule_card.dart';
import '../../../../video_call/presentation/screens/chat_screen.dart';
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
            child: Text('No booked schedules.'),
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
                    builder: (context) => ChatScreen(
                      chatWithName: schedule.teacherName,
                      scheduleId: schedule.id,
                      userName: schedule.studentName,
                      userId: schedule.studentId,
                    ),
                  ),
                );
              },
              child: ScheduleCard(
                title: 'Teacher Name',
                date: schedule.date,
                studentName: schedule.teacherName,
                studentId: schedule.teacherId,
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
