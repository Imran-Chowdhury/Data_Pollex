import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';

class ScheduleCard extends StatelessWidget {
  final String date;
  final String studentName;
  final String studentId;
  final bool isBooked;

  const ScheduleCard({
    super.key,
    required this.date,
    required this.studentName,
    required this.studentId,
    required this.isBooked,
  });

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
                    'Student: $studentName',
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
              isBooked ? Icons.check_circle : Icons.pending,
              color: isBooked ? Colors.green : Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
