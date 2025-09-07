import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../widgets/flag_tile.dart';
import '../../../available_teachers/presentation/screens/available_teacher_screen.dart';
import '../../../booked_lessons/presentation/screens/booked_lesson_screen.dart';

class StudentLessonList extends ConsumerWidget {
  const StudentLessonList({super.key, required this.whereTo});
  final String whereTo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(manageLessonsProvider);

    const languages = [
      'Bangla',
      'French',
      'Russian',
      'English',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16), // optional padding inside container
      itemCount: languages.length,
      itemBuilder: (context, i) {
        final langs = languages[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => whereTo == 'Teacher Availability'
                      ? TeacherAvailabilityScreen(language: langs)
                      : BookedSchedulesScreen(language: langs),
                ),
              );
            },
            child: FlagTile(
              countryName: langs,
              flagAssetPath: 'assets/$langs.png',
            ),
          ),
        );
      },
    );
  }
}
