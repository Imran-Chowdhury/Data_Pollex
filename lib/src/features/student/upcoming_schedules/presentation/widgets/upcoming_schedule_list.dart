import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/color.dart';
import '../../../../teacher/booked_lessons/presentation/widget/schedule_card.dart';
import '../view_model/upcoming_schedule_view_model.dart';

class UpcomingScheduleList extends ConsumerWidget {
  const UpcomingScheduleList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final studentId = ref.read(authViewModelProvider).user!.id;
    final schedulesAsync = ref.watch(studentScheduleProvider);

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
                // Removed video call navigation as per your request
              },
              child: CustomCard(
                subtitle: 'Teacher Name',
                mainText: schedule['date'], // Show date of schedule
                userName: schedule['teacherName'], // Teacher's name
                userId: schedule['teacherId'], // Teacher's ID
                isBooked: schedule['isBooked'], // Booking status
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
