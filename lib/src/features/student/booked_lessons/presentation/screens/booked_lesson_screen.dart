import 'package:data_pollex/src/widgets/background_container.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../widget/student_date_list.dart';

class BookedSchedulesScreen extends StatelessWidget {
  // final String studentId;
  final String language;

  const BookedSchedulesScreen({
    super.key,
    // required this.studentId,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        title: const Text(
          'Booked Schedules',
          style: TextStyle(
            color: CustomColor.white,
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StudentDateList(
            language: language,
          ),
        ),
      ),

      // schedulesAsync.when(
      //   data: (schedules) {
      //     if (schedules.isEmpty) {
      //       return const Center(
      //         child: Text('No booked schedules.'),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: schedules.length,
      //       itemBuilder: (context, index) {
      //         final schedule = schedules[index];
      //         return GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => ChatScreen(
      //                   userName: schedule.studentName,
      //                   chatWithName: schedule.teacherName,
      //                   scheduleId: schedule.id,
      //                   userId: schedule.studentId,
      //                 ),
      //               ),
      //             );
      //           },
      //           child: Card(
      //             margin:
      //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //             child: ListTile(
      //               title: Text(schedule.date),
      //               subtitle: Text(
      //                   'Student: ${schedule.studentName ?? 'N/A'}\nTeacher: ${schedule.teacherName}'),
      //               trailing: schedule.isBooked
      //                   ? const Icon(Icons.check_circle, color: Colors.green)
      //                   : const Icon(Icons.pending, color: Colors.grey),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (e, _) => Center(
      //     child: Text(
      //       'Error loading schedules: $e',
      //       style: const TextStyle(color: Colors.red),
      //     ),
      //   ),
      // ),
    );
  }
}
