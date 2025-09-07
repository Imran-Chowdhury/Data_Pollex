import 'package:data_pollex/src/features/student/available_teachers/presentation/widget/teacher_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../teacher_date/presentation/screens/teacher_dates_screen.dart';
import '../provider/teacher_by_lang_provider.dart';

class TeacherList extends ConsumerWidget {
  final String language;
  const TeacherList({super.key, required this.language});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsync = ref.watch(teachersByLanguageProvider(language));

    return teachersAsync.when(
      data: (teachers) {
        if (teachers.isEmpty) {
          return Center(child: Text("No teachers found for $language"));
        }
        return ListView.builder(
          itemCount: teachers.length,
          itemBuilder: (context, index) {
            final teacher = teachers[index];
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherDatesScreen(
                        teacherName: teachers[index].name,
                        teacherId: teachers[index].id,
                        language: language,
                      ),
                    ),
                  );
                },
                child: TeacherCard(
                    teacherName: teacher.name,
                    email: teacher.email,
                    userId: teacher.id,
                    subtitle: 'Email'));
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        // 👉 Show offline / no internet message
        return const Center(
          child: Text(
            "No data available. Please check your internet connection.",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
