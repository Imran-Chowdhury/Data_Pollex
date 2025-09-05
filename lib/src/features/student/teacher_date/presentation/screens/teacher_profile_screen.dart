import 'package:flutter/material.dart';

class TeacherProfileScreen extends StatelessWidget {
  final String teacherName;
  final VoidCallback onBook;

  const TeacherProfileScreen({
    super.key,
    required this.teacherName,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(teacherName)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Teacher: $teacherName"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onBook,
              child: const Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
