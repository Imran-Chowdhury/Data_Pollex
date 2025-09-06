import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:data_pollex/src/features/video_call/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/booked_lesson_view_model.dart';

class BookedSchedulesScreen extends ConsumerWidget {
  // final String studentId;
  final String language;

  const BookedSchedulesScreen({
    super.key,
    // required this.studentId,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentId = ref.read(authViewModelProvider).user!.id;
    final schedulesAsync = ref.watch(bookedSchedulesProvider(
      StudentLanguage(studentId: studentId, language: language),
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Schedules'),
      ),
      body: schedulesAsync.when(
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
                        userName: schedule.studentName,
                        chatWithName: schedule.teacherName,
                        scheduleId: schedule.id,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(schedule.date),
                    subtitle: Text(
                        'Student: ${schedule.studentName ?? 'N/A'}\nTeacher: ${schedule.teacherName}'),
                    trailing: schedule.isBooked
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.pending, color: Colors.grey),
                  ),
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
      ),
    );
  }
}
