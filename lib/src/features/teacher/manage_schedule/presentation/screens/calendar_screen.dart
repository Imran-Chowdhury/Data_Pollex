import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarView _calendarView = CalendarView.month;
  final List<String> _languages = ['English', 'Bangla', 'Russian', 'French'];
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  /// Try online first, then SharedPreferences
  Future<void> _fetchAppointments() async {
    try {
      // Try fetching from Firestore
      final snapshot =
          await FirebaseFirestore.instance.collection('schedules').get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();

      final appointments = data.map((item) {
        return Appointment(
          startTime: DateTime.parse(item['date']),
          endTime: DateTime.parse(item['date']).add(const Duration(hours: 1)),
          subject: "${item['courseName']} (${item['teacherName']})",
          color: item['isBooked'] ? Colors.grey : Colors.blue,
        );
      }).toList();

      setState(() => _appointments = appointments);

      // Save to SharedPreferences for offline
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('appointments', jsonEncode(data));
    } catch (e) {
      // If Firestore fails, fallback to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final storedData = prefs.getString('appointments');
      if (storedData != null) {
        final List decoded = jsonDecode(storedData);
        setState(() {
          _appointments = decoded.map((item) {
            return Appointment(
              startTime: DateTime.parse(item['date']),
              endTime:
                  DateTime.parse(item['date']).add(const Duration(hours: 1)),
              subject: "${item['courseName']} (${item['teacherName']})",
              color: item['isBooked'] ? Colors.grey : Colors.blue,
            );
          }).toList();
        });
      } else {
        setState(() => _appointments = []); // No data, show empty calendar
      }
    }
  }

  Future<void> _addAppointment(DateTime selectedDate, String courseName) async {
    final newSchedule = {
      "courseName": courseName.toLowerCase(),
      "teacherId": "johnId", // TODO: replace with logged in teacherId
      "teacherName": "John", // TODO: replace with logged in teacherName
      "date": DateFormat('yyyy-MM-dd').format(selectedDate),
      "isBooked": false,
    };

    try {
      // Add to Firestore
      await FirebaseFirestore.instance.collection('schedules').add(newSchedule);

      // Add to local appointments
      setState(() {
        _appointments.add(
          Appointment(
            startTime: selectedDate,
            endTime: selectedDate.add(const Duration(hours: 1)),
            subject:
                "${newSchedule['courseName']} (${newSchedule['teacherName']})",
            color: Colors.blue,
          ),
        );
      });

      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final storedData = prefs.getString('appointments');
      List list = storedData != null ? jsonDecode(storedData) : [];
      list.add(newSchedule);
      await prefs.setString('appointments', jsonEncode(list));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add appointment online")),
      );
    }
  }

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
              onPressed: () async {
                if (selectedLanguage != null) {
                  await _addAppointment(selectedDate, selectedLanguage!);
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

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
