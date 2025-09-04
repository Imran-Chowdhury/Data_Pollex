import 'package:data_pollex/src/features/teacher/manage_schedule/presentation/view_model/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'lesson_selector.dart';

class AddBookingDialogWidget extends ConsumerWidget {
  const AddBookingDialogWidget({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider).valueOrNull;

    return AlertDialog(
      title: Text(
        'Add Appointment: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
      ),
      content: (lessons == null || lessons.isEmpty)
          ? const Text(
              'Please add lessons from Manage Lessons',
              style: TextStyle(color: Colors.redAccent),
            )
          : LessonSelector(
              lessons: lessons,
              selectedDate: selectedDate,
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

// class AddBookingDialogWidget extends ConsumerWidget {
//   const AddBookingDialogWidget({super.key, required this.selectedDate});
//   final DateTime selectedDate;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // const List<String> languages = ['English', 'Bangla', 'Russian', 'French'];
//     final lessons = ref.read(lessonsProvider).valueOrNull;
//     log('The lessons are $lessons');
//     String? selectedLanguage = lessons![0];
//
//     return AlertDialog(
//       title: Text(
//           'Add Appointment: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
//       content: StatefulBuilder(
//         builder: (context, setStateDialog) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: lessons.map((lang) {
//               return RadioListTile<String>(
//                 title: Text(lang),
//                 value: lang,
//                 groupValue: selectedLanguage,
//                 onChanged: (value) {
//                   setStateDialog(() {
//                     selectedLanguage = value;
//                   });
//                 },
//               );
//             }).toList(),
//           );
//         },
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () async {
//             if (selectedLanguage != null) {
//               await ref.read(scheduleControllerProvider.notifier).addSchedule({
//                 "courseName": selectedLanguage,
//                 "teacherId": ref.read(authViewModelProvider).user!.id,
//                 "teacherName": ref.read(authViewModelProvider).user!.name,
//                 "date": DateTime.now().toIso8601String(),
//                 "isBooked": false,
//               });
//             }
//             Navigator.of(context).pop();
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     );
//   }
// }
