import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/manage_lessons_provider.dart';

class AddLanguageDialog extends ConsumerStatefulWidget {
  final String teacherId;
  const AddLanguageDialog({super.key, required this.teacherId});

  @override
  ConsumerState<AddLanguageDialog> createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends ConsumerState<AddLanguageDialog> {
  String? selectedLanguage;

  final langs = ["Bangla", "English", "Russian", "French"];

  @override
  Widget build(BuildContext context) {
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
      actions: [
        TextButton(
          onPressed: () async {
            if (selectedLanguage != null) {
              await ref
                  .read(manageLessonsProvider.notifier)
                  .addLanguage(widget.teacherId, selectedLanguage!);

              final state = ref.read(manageLessonsProvider);
              if (state.hasError) {
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
