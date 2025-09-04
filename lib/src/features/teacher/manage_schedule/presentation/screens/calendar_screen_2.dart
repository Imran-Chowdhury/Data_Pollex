import 'dart:convert';
import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../view_model/calendar_view_model.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(scheduleControllerProvider).valueOrNull;
    final CalendarView _calendarView = CalendarView.month;
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: SfCalendar(
        view: _calendarView,
        showDatePickerButton: true,
        initialSelectedDate: DateTime.now(),
        onTap: (CalendarTapDetails details) {
          if (details.date != null) {
            final DateTime selectedDate = details.date!;
            _showAddAppointmentDialog(selectedDate, context, ref);
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await ref.read(scheduleControllerProvider.notifier).addSchedule({
      //       "courseName": "english",
      //       "teacherId": ref.read(authViewModelProvider).user!.id,
      //       "teacherName": ref.read(authViewModelProvider).user!.name,
      //       "date": DateTime.now().toIso8601String(),
      //       "isBooked": false,
      //     });
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void _showAddAppointmentDialog(
      DateTime selectedDate, BuildContext context, WidgetRef ref) {
    final List<String> languages = ['English', 'Bangla', 'Russian', 'French'];

    String? selectedLanguage = languages[0];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Add Appointment: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: languages.map((lang) {
                  return RadioListTile<String>(
                    title: Text(lang),
                    value: lang,
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setStateDialog(() {
                        selectedLanguage = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (selectedLanguage != null) {
                  await ref
                      .read(scheduleControllerProvider.notifier)
                      .addSchedule({
                    "courseName": selectedLanguage,
                    "teacherId": ref.read(authViewModelProvider).user!.id,
                    "teacherName": ref.read(authViewModelProvider).user!.name,
                    "date": DateTime.now().toIso8601String(),
                    "isBooked": false,
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

void _showAppointmentsDialog(DateTime selectedDate, WidgetRef ref,
    BuildContext context, double width, double height) {
  final appointmentsForDate = ref
      .read(scheduleControllerProvider)
      .value
      ?.where((a) =>
          a.startTime.year == selectedDate.year &&
          a.startTime.month == selectedDate.month &&
          a.startTime.day == selectedDate.day)
      .toList();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
            'Appointments: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
        content: SizedBox(
          width: width * 0.6,
          height: height * 0.4,
          child: appointmentsForDate.isEmpty
              ? const Center(child: Text('No appointments'))
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
              _showAddAppointmentDialog(selectedDate);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
