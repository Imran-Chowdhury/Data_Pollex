import 'package:data_pollex/src/features/teacher/manage_schedule/data/datasource/data_source.dart';
import 'package:data_pollex/src/features/teacher/manage_schedule/service/schedule_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final scheduleRepositoryProvider = Provider((ref) {
  return ScheduleRepository(
    ref.read(calendarRemoteProvider),
    ref.read(calendarLocalProvider),
  );
});

class ScheduleRepository {
  final CalendarRemoteDataSource remote;
  final ScheduleStorageService localDB;

  ScheduleRepository(this.remote, this.localDB);

  Future<List<Appointment>> getSchedules() async {
    try {
      // Try fetching online
      final data = await remote.fetchSchedules();
      final appointments = _mapToAppointments(data);

      ///Syncing locally
      await localDB.saveSchedules(data);

      return appointments;
    } catch (_) {
      // If Firestore fails, fallback to local
      final localData = await localDB.getSchedules();
      if (localData != null) {
        return _mapToAppointments(localData);
      }
      return []; // No data available
    }
  }

  Future<bool> addSchedule(Map<String, dynamic> schedule) async {
    try {
      await remote.addSchedule(schedule);

      // Refresh local cache
      final schedules = await remote.fetchSchedules();
      await localDB.saveSchedules(schedules);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Helper method to convert the data to appointment for calendar
  List<Appointment> _mapToAppointments(List<Map<String, dynamic>> data) {
    return data.map((item) {
      return Appointment(
        startTime: DateTime.parse(item['date']),
        endTime: DateTime.parse(item['date']).add(const Duration(hours: 1)),
        subject: "${item['courseName']} (${item['teacherName']})",
        color: item['isBooked'] ? Colors.grey : Colors.blue,
      );
    }).toList();
  }
}
