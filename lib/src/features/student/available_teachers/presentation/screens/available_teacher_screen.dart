import 'package:flutter/material.dart';

import '../widget/teacher_list.dart';

class TeacherAvailabilityScreen extends StatelessWidget {
  const TeacherAvailabilityScreen({super.key, required this.language});
  final String language;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$language Teachers"),
        backgroundColor: Colors.deepPurple,
      ),
      body: TeacherList(
        language: language,
      ),
    );
  }
}
