import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../view_model/calendar_view_model.dart';
import '../widgets/appointment_dialog.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(scheduleControllerProvider).valueOrNull;
    final CalendarView calendarView = CalendarView.month;

    ref.listen<AsyncValue<List<Appointment>>>(
      scheduleControllerProvider,
      (previous, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error.toString()),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: SfCalendar(
        view: calendarView,
        showDatePickerButton: true,
        initialSelectedDate: DateTime.now(),
        onTap: (CalendarTapDetails details) {
          if (details.date != null) {
            final DateTime selectedDate = details.date!;

            /// Display the dialog for all bookings of the day
            showBookings(context, selectedDate);
          }
        },
        dataSource: AppointmentDataSource(schedules ?? []),
        todayHighlightColor: const Color(0xFFd71e23),
        headerStyle: const CalendarHeaderStyle(
          backgroundColor: Color(0xFFd71e23),
          textStyle: TextStyle(color: Colors.white),
        ),
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
      ),
    );
  }

  void showBookings(BuildContext context, DateTime selectedDate) {
    showDialog(
        context: context,
        builder: (context) {
          return AppointmentDialogWidget(
            selectedDate: selectedDate,
          );
        });
  }
}
// class CalendarScreen extends ConsumerStatefulWidget {
//   const CalendarScreen({super.key});
//
//   @override
//   ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
// }
//
// class _CalendarScreenState extends ConsumerState<CalendarScreen> {
//   final CalendarView _calendarView = CalendarView.month;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ref.listenManual(scheduleControllerProvider, (prev, next) {
//       if (next.hasError) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(next.error.toString())),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final schedules = ref.watch(scheduleControllerProvider).valueOrNull;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Calendar")),
//       body: SfCalendar(
//         view: _calendarView,
//         showDatePickerButton: true,
//         initialSelectedDate: DateTime.now(),
//         onTap: (CalendarTapDetails details) {
//           if (details.date != null) {
//             final DateTime selectedDate = details.date!;
//             _showBookings(context, selectedDate);
//           }
//         },
//         dataSource: AppointmentDataSource(schedules ?? []),
//         todayHighlightColor: const Color(0xFFd71e23),
//         headerStyle: const CalendarHeaderStyle(
//           backgroundColor: Color(0xFFd71e23),
//           textStyle: TextStyle(color: Colors.white),
//         ),
//         monthViewSettings: const MonthViewSettings(
//           appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
//         ),
//       ),
//     );
//   }
//
//   void _showBookings(BuildContext context, DateTime selectedDate) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AppointmentDialogWidget(
//           selectedDate: selectedDate,
//         );
//       },
//     );
//   }
// }

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
