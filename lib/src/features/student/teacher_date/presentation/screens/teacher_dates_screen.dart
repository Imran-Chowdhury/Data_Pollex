import 'package:flutter/material.dart';

import '../widget/teacher_date_list.dart';

class TeacherDatesScreen extends StatelessWidget {
  final String teacherId;
  final String language;

  const TeacherDatesScreen({
    super.key,
    required this.teacherId,
    required this.language,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Available Dates")),
        body: TeacherDatesList(
          teacherId: teacherId,
          language: language,
        ));
  }
}
