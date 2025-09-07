import 'package:data_pollex/src/features/teacher/booked_lessons/presentation/widget/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../../video_call/presentation/screens/chat_screen.dart';
import '../view_model/booked_lesson_view_model.dart';

class DateList extends ConsumerWidget {
  const DateList({super.key, required this.language});
  final String language;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherId = ref.read(authViewModelProvider).user!.id;
    final schedulesAsync = ref.watch(teacherBookedSchedulesProvider(
      BookedLanguage(userId: teacherId, language: language),
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
                      chatWithName: schedule.studentName,
                      scheduleId: schedule.id,
                      userName: schedule.teacherName,
                      userId: schedule.teacherId,
                    ),
                  ),
                );
              },
              child: ScheduleCard(
                date: schedule.date,
                studentName:
                    schedule.studentName.isEmpty ? 'N/A' : schedule.studentName,
                studentId:
                    schedule.studentId.isEmpty ? 'N/A' : schedule.studentId,
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
