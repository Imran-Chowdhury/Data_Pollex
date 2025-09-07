import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';

class TeacherCard extends StatelessWidget {
  final String teacherName;
  final String email;
  final String userId;
  // final bool isBooked;
  final String subtitle;

  const TeacherCard({
    super.key,
    required this.teacherName,
    required this.email,
    required this.userId,
    // required this.isBooked,
    required this.subtitle,
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
                    teacherName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: CustomColor.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$subtitle: $email',
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

            const Icon(
              Icons.arrow_forward_ios,
              color: CustomColor.primary,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
