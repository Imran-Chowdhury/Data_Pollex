import 'dart:developer';

import 'package:data_pollex/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/auth_providers.dart';
import '../view_model/calendar_view_model.dart';
import 'calendar_button.dart';

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
            activeColor: CustomColor.primaryDark,
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

        // Buttons side by side
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Cancel Button
              const CalendarCancelButton(),

              const SizedBox(width: 12),
              // Add Button
              CalendarSetButton(
                title: 'Add',
                onClicked: () async {
                  // final lessonSelectorState = context
                  //     .findAncestorStateOfType<LessonSelectorState>();
                  // final selectedLanguage =
                  //     lessonSelectorState?.selectedLanguage;
                  log('The selected language is $selectedLanguage');
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
