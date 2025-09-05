import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(teacher.name),
                subtitle: Text("Email: ${teacher.email}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // 👉 Navigate to teacher profile/details
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          const Center(child: Text("Error occurred while fetching teachers")),
    );
  }
}
