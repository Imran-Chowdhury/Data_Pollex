import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';

class ScheduleCard extends StatelessWidget {
  final String date;
  final String studentName;
  final String studentId;
  final bool isBooked;
  final String title;

  const ScheduleCard(
      {super.key,
      required this.date,
      required this.studentName,
      required this.studentId,
      required this.isBooked,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left calendar icon
            const Icon(
              Icons.calendar_today,
              size: 36,
              color: CustomColor.primary,
            ),
            const SizedBox(width: 12),
            // Info column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: CustomColor.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$title: $studentName',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      // color: CustomColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing booking status

            Icon(
              isBooked ? Icons.video_call : Icons.video_call,
              color: CustomColor.primary,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
