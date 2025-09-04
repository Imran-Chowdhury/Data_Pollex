import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/manage_lesson_view_model.dart';
import '../widgets/add_language_dialog.dart';

class ManageLessonsScreen extends ConsumerWidget {
  const ManageLessonsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(manageLessonsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Lessons")),
      // body: state.when(
      //   data: (langs) => ListView.builder(
      //     itemCount: langs.length,
      //     itemBuilder: (context, i) {
      //       return Card(
      //         child: ListTile(
      //           title: Text(langs[i]),
      //         ),
      //       );
      //     },
      //   ),
      //   loading: () => null,
      //   // error: (e, _) => Center(child: Text(e.toString())),
      //   error: (e, _) => null,
      // ),

      body: ListView.builder(
        itemCount: state.valueOrNull?.length ?? 0,
        itemBuilder: (context, i) {
          final langs = state.valueOrNull!;
          return Card(
            child: ListTile(title: Text(langs[i])),
          );
        },
      ),

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
