import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageLessonsScreen extends ConsumerWidget {
  final String teacherId;
  const ManageLessonsScreen({super.key, required this.teacherId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(manageLessonsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Lessons")),
      body: state.when(
        data: (langs) => ListView.builder(
          itemCount: langs.length,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Text(langs[i].language),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddLanguageDialog(teacherId: teacherId),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
