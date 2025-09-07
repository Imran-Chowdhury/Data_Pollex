import 'package:data_pollex/src/features/teacher/manage_schedule/presentation/view_model/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/color.dart';
import 'lesson_selector.dart';

class AddBookingDialogWidget extends ConsumerWidget {
  const AddBookingDialogWidget({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider).valueOrNull;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
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
              child: Text(
                'Add Appointment: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                style: const TextStyle(
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
                child: (lessons == null || lessons.isEmpty)
                    ? const Center(
                        child: Text(
                          'Please add lessons from Manage Lessons',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : SingleChildScrollView(
                        child: LessonSelector(
                          lessons: lessons,
                          selectedDate: selectedDate,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
