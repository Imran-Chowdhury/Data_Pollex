import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarView _calendarView = CalendarView.month;
  final List<Appointment> _appointments = [];
  final List<String> _languages = ['English', 'Bangla', 'Russian', 'French'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    double height = size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFd71e23),
        title: const Text('Set your schedule'),
      ),
      body: SfCalendar(
        view: _calendarView,
        showDatePickerButton: true,
        initialSelectedDate: DateTime.now(),
        onTap: (CalendarTapDetails details) {
          if (details.date != null) {
            final DateTime selectedDate = details.date!;
            _showAppointmentsDialog(selectedDate, width, height);
          }
        },
        dataSource: AppointmentDataSource(_appointments),
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

  void _showAppointmentsDialog(
      DateTime selectedDate, double width, double height) {
    final appointmentsForDate = _appointments
        .where((a) =>
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
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close list dialog first
                _showAddAppointmentDialog(selectedDate);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddAppointmentDialog(DateTime selectedDate) {
    String? selectedLanguage = _languages[0];

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
                children: _languages.map((lang) {
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
              onPressed: () {
                if (selectedLanguage != null) {
                  setState(() {
                    _appointments.add(
                      Appointment(
                        startTime: selectedDate,
                        endTime: selectedDate.add(const Duration(hours: 1)),
                        subject: selectedLanguage!,
                        color: Colors.blue,
                      ),
                    );
                  });
                }
                Navigator.of(context).pop(); // Close add dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
