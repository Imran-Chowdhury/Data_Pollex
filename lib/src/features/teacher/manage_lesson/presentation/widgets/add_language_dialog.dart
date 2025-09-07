import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/color.dart';
import '../../../manage_schedule/presentation/widgets/calendar_button.dart';
import '../view_model/manage_lesson_view_model.dart';

class AddLanguageDialog extends ConsumerStatefulWidget {
  const AddLanguageDialog({super.key});

  @override
  ConsumerState<AddLanguageDialog> createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends ConsumerState<AddLanguageDialog> {
  String? selectedLanguage;
  final langs = const ["Bangla", "English", "Russian", "Dutch"];

  @override
  void initState() {
    super.initState();
    selectedLanguage = langs.first;
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(manageLessonsProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 12,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          minWidth: 280,
          maxWidth: 320,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: const BoxDecoration(
                color: CustomColor.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: const Text(
                'Select Language',
                style: TextStyle(
                  color: CustomColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            // Body scrollable
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: langs.map((lang) {
                    return RadioListTile<String>(
                      activeColor: CustomColor.primary,
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
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CalendarCancelButton(),
                  const SizedBox(width: 12),
                  CalendarSetButton(
                    title: 'Add',
                    onClicked: lessonState.isLoading
                        ? null
                        : () async {
                            if (selectedLanguage != null) {
                              final teacherID =
                                  ref.read(authViewModelProvider).user!.id;

                              await ref
                                  .read(manageLessonsProvider.notifier)
                                  .addLanguage(teacherID, selectedLanguage!);

                              final state = ref.read(manageLessonsProvider);
                              if (state.hasError) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.error.toString(),
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
