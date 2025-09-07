import 'package:data_pollex/src/widgets/background_container.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../widgets/lesson_list_student.dart';

class LanguageOptionScreen extends StatelessWidget {
  const LanguageOptionScreen({super.key, required this.whereTo});

  final String whereTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        title: const Text(
          "Select Lesson",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColor.white,
          ),
        ),
      ),
      body: BackgroundContainer(
        child: StudentLessonList(whereTo: whereTo),
      ),
    );
  }
}
