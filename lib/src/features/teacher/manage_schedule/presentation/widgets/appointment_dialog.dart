import 'package:data_pollex/src/features/teacher/manage_schedule/presentation/view_model/calendar_view_model.dart';
import 'package:data_pollex/src/features/teacher/manage_schedule/presentation/widgets/add_booking_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AppointmentDialogWidget extends ConsumerWidget {
  const AppointmentDialogWidget({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsForDate = ref
        .read(scheduleControllerProvider)
        .value!
        .where((a) =>
            a.startTime.year == selectedDate.year &&
            a.startTime.month == selectedDate.month &&
            a.startTime.day == selectedDate.day)
        .toList();
    return AlertDialog(
      title: Text(
          'Appointments: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
      content: SizedBox(
        // width: width * 0.6,
        // height: height * 0.4,
        width: 200,
        height: 400,
        child: appointmentsForDate.isEmpty
            ? const Center(child: Text('No bookings'))
            : ListView.builder(
                itemCount: appointmentsForDate.length,
                itemBuilder: (context, index) {
                  final appointment = appointmentsForDate[index];
                  return ListTile(
                    title: Text(appointment.subject),
                    subtitle: Text(appointment.color == Colors.grey
                        ? "Booked"
                        : "Available"),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // _showAddAppointmentDialog(selectedDate);
            addBooking(context, selectedDate);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  void addBooking(BuildContext context, DateTime selectedDate) {
    showDialog(
        context: context,
        builder: (context) {
          return AddBookingDialogWidget(selectedDate: selectedDate);
        });
  }
}

// void _showAppointmentsDialog(DateTime selectedDate, WidgetRef ref,
//     BuildContext context, double width, double height) {
//   final appointmentsForDate = ref
//       .read(scheduleControllerProvider)
//       .value
//       ?.where((a) =>
//           a.startTime.year == selectedDate.year &&
//           a.startTime.month == selectedDate.month &&
//           a.startTime.day == selectedDate.day)
//       .toList();
//
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text(
//             'Appointments: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
//         content: SizedBox(
//           width: width * 0.6,
//           height: height * 0.4,
//           child: appointmentsForDate.isEmpty
//               ? const Center(child: Text('No appointments'))
//               : ListView.builder(
//                   itemCount: appointmentsForDate.length,
//                   itemBuilder: (context, index) {
//                     final appointment = appointmentsForDate[index];
//                     return ListTile(
//                       title: Text(appointment.subject),
//                       subtitle: Text(appointment.color == Colors.grey
//                           ? "Booked"
//                           : "Available"),
//                     );
//                   },
//                 ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _showAddAppointmentDialog(selectedDate);
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       );
//     },
//   );
// }
