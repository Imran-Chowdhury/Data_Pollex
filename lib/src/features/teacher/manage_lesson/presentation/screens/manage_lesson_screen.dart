import 'package:data_pollex/src/core/utils/color.dart';

import 'package:flutter/material.dart';

import '../../../../../widgets/background_container.dart';

import '../widgets/add_language_dialog.dart';
import '../widgets/lesson_list.dart';

class ManageLessonsScreen extends StatelessWidget {
  const ManageLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
          backgroundColor: CustomColor.primary,
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
        backgroundColor: CustomColor.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddLanguageDialog(),
          );
        },
        child: const Icon(
          Icons.add,
          color: CustomColor.white,
        ),
      ),
    );
  }
}
