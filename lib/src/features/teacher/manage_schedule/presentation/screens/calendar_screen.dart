import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../core/utils/color.dart';
import '../../../manage_lesson/presentation/view_model/manage_lesson_view_model.dart';
import '../view_model/calendar_view_model.dart';
import '../widgets/appointment_dialog.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson = ref.watch(manageLessonsProvider);
    final schedules = ref.watch(scheduleControllerProvider).valueOrNull;
    final CalendarView calendarView = CalendarView.month;

    ref.listen<AsyncValue<List<Appointment>>>(
      scheduleControllerProvider,
      (previous, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error.toString()),
              // backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.primary,
          title: const Text(
            "Set Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColor.white,
            ),
          ),
        ),
        body: SfCalendar(
          view: calendarView,
          showDatePickerButton: true,
          initialSelectedDate: DateTime.now(),
          // onTap: (CalendarTapDetails details) {
          //   if (details.date != null) {
          //     final DateTime selectedDate = details.date!;
          //     showBookings(context, selectedDate);
          //   }
          // },

          onTap: (CalendarTapDetails details) {
            if (details.targetElement == CalendarElement.calendarCell &&
                details.date != null) {
              final DateTime selectedDate = details.date!;
              showBookings(context, selectedDate);
            }
          },

          dataSource: AppointmentDataSource(schedules ?? []),
          todayHighlightColor: CustomColor.red, // Red dot stands out on teal
          selectionDecoration: BoxDecoration(
            color: CustomColor.primary.withOpacity(0.2), // soft teal background
            border: Border.all(color: CustomColor.primary, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: CustomColor.primary, // matches brand
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          viewHeaderStyle: const ViewHeaderStyle(
            backgroundColor: Color(0xFF2f5c5a), // darker teal for weekdays
            dayTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            dateTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            monthCellStyle: MonthCellStyle(
              // todayBackgroundColor:
              //     CustomColor.primary, // highlights today cell
              textStyle: TextStyle(color: Colors.black87),
              trailingDatesTextStyle: TextStyle(color: Colors.grey),
              leadingDatesTextStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ));
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

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
