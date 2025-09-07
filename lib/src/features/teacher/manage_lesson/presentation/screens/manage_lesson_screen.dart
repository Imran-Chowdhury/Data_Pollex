import 'package:data_pollex/src/core/utils/color.dart';
import 'package:data_pollex/src/widgets/flag_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../widgets/background_container.dart';
import '../../../booked_lessons/presentation/screens/teacher_booked_lesson_screen.dart';
import '../view_model/manage_lesson_view_model.dart';
import '../widgets/add_language_dialog.dart';
import '../widgets/lesson_list.dart';

class ManageLessonsScreen extends StatelessWidget {
  const ManageLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      appBar: AppBar(
          backgroundColor: CustomColor.primaryColor,
          title: const Text(
            "Manage Lessons",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColor.white,
            ),
          )),
      body: const BackgroundContainer(
        child: LessonList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddLanguageDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
