import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/auth_providers.dart';
import '../view_model/calendar_view_model.dart';

class LessonSelector extends StatefulWidget {
  const LessonSelector({
    required this.lessons,
    required this.selectedDate,
  });

  final List<String> lessons;
  final DateTime selectedDate;

  @override
  State<LessonSelector> createState() => LessonSelectorState();
}

class LessonSelectorState extends State<LessonSelector> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.lessons.first;
  }

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...widget.lessons.map(
          (lang) => RadioListTile<String>(
            title: Text(lang),
            value: lang,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = value;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () async {
              if (selectedLanguage != null) {
                await ref
                    .read(scheduleControllerProvider.notifier)
                    .addSchedule({
                  "language": selectedLanguage,
                  "teacherId": ref.read(authViewModelProvider).user!.id,
                  "teacherName": ref.read(authViewModelProvider).user!.name,
                  "date": widget.selectedDate.toIso8601String(),
                  "isBooked": false,
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }
}
