import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../widgets/flag_tile.dart';
import '../../../booked_lessons/presentation/screens/teacher_booked_lesson_screen.dart';
import '../view_model/manage_lesson_view_model.dart';

class LessonList extends ConsumerWidget {
  const LessonList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(manageLessonsProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(16), // optional padding inside container
      itemCount: state.valueOrNull?.length ?? 0,
      itemBuilder: (context, i) {
        final langs = state.valueOrNull!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherBookedLessonScreen(
                    language: langs[i],
                  ),
                ),
              );
            },
            child: FlagTile(
              countryName: langs[i],
              flagAssetPath: 'assets/${langs[i]}.png',
            ),
          ),
        );
      },
    );
  }
}
