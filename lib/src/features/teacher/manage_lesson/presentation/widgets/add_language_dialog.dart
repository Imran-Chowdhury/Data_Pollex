import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/manage_lesson_view_model.dart';

class AddLanguageDialog extends ConsumerStatefulWidget {
  const AddLanguageDialog({
    super.key,
  });

  @override
  ConsumerState<AddLanguageDialog> createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends ConsumerState<AddLanguageDialog> {
  String? selectedLanguage;

  final langs = const ["Bangla", "English", "Russian", "French"];

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(manageLessonsProvider);
    return AlertDialog(
      title: const Text("Select Language"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: langs.map((lang) {
          return RadioListTile<String>(
            title: Text(lang),
            value: lang,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = value;
              });
            },
          );
        }).toList(),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () async {
      //       if (selectedLanguage != null) {
      //         final teacherID = ref.read(authViewModelProvider).user!.id;
      //         await ref
      //             .read(manageLessonsProvider.notifier)
      //             .addLanguage(teacherID, selectedLanguage!);
      //
      //         final state = ref.read(manageLessonsProvider);
      //         if (state.hasError) {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(content: Text(state.error.toString())),
      //           );
      //         } else {
      //           Navigator.pop(context);
      //         }
      //       }
      //     },
      //     child: const Text("Save"),
      //   ),
      // ],

      actions: [
        if (lessonState.isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        else
          TextButton(
            onPressed: () async {
              if (selectedLanguage != null) {
                final teacherID = ref.read(authViewModelProvider).user!.id;
                await ref
                    .read(manageLessonsProvider.notifier)
                    .addLanguage(teacherID, selectedLanguage!);

                final state = ref.read(manageLessonsProvider);
                if (state.hasError) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error.toString())),
                  );
                } else {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text("Save"),
          ),
      ],
    );
  }
}
