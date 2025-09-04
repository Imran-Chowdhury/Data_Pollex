import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/manage_lesson_view_model.dart';
import '../widgets/add_language_dialog.dart';

class ManageLessonsScreen extends StatelessWidget {
  const ManageLessonsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(manageLessonsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Lessons")),
      body: const LessonList(),
      floatingActionButton: FloatingActionButton(
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

class LessonList extends ConsumerWidget {
  const LessonList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(manageLessonsProvider);

    return ListView.builder(
      itemCount: state.valueOrNull?.length ?? 0,
      itemBuilder: (context, i) {
        final langs = state.valueOrNull!;
        return Card(
          child: ListTile(title: Text(langs[i])),
        );
      },
    );
  }
}
