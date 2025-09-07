import 'package:data_pollex/src/widgets/background_container.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../widget/teacher_date_list.dart';

class TeacherDatesScreen extends StatelessWidget {
  final String teacherId;
  final String language;
  final String teacherName;

  const TeacherDatesScreen({
    super.key,
    required this.teacherId,
    required this.language,
    required this.teacherName,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.primary,
        appBar: AppBar(
          backgroundColor: CustomColor.primary,
          title: Text(
            teacherName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColor.white,
            ),
          ),
        ),
        body: BackgroundContainer(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TeacherDatesList(
              teacherId: teacherId,
              language: language,
            ),
          ),
        ));
  }
}
