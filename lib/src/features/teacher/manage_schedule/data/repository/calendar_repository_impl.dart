import 'package:data_pollex/src/features/teacher/manage_schedule/data/datasource/data_source.dart';
import 'package:data_pollex/src/features/teacher/manage_schedule/service/schedule_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../core/base_state/remote_response.dart';

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
    final response = await remote.fetchSchedules();

    if (response is RemoteSuccess<List<Map<String, dynamic>>>) {
      final data = response.data;
      final appointments = _mapToAppointments(data);

      // Sync with local storage
      await localDB.saveSchedules(data);

      return appointments;
    } else if (response is RemoteFailure) {
      // fallback to local if Firestore fails
      final localData = await localDB.getSchedules();
      if (localData != null) {
        return _mapToAppointments(localData);
      }
      return []; // nothing available
    }

    return [];
  }

  Future<RemoteResponse<void>> addSchedule(
      Map<String, dynamic> schedule) async {
    final response = await remote.addSchedule(schedule);

    if (response is RemoteSuccess<void>) {
      // Refresh cache only if remote succeeded
      final fetchResponse = await remote.fetchSchedules();

      if (fetchResponse is RemoteSuccess<List<Map<String, dynamic>>>) {
        await localDB.saveSchedules(fetchResponse.data);
      }

      return RemoteSuccess(null);
    } else if (response is RemoteFailure) {
      return RemoteFailure(response.message, statusCode: response.statusCode);
    }

    return RemoteFailure("Unknown error occurred");
  }

  /// Convert raw data into calendar appointments
  List<Appointment> _mapToAppointments(List<Map<String, dynamic>> data) {
    return data.map((item) {
      return Appointment(
        startTime: DateTime.parse(item['date']),
        endTime: DateTime.parse(item['date']).add(const Duration(hours: 1)),
        subject: "${item['language']} (${item['teacherName']})",
        color: (item['isBooked'] ?? false) ? Colors.grey : Colors.blue,
      );
    }).toList();
  }
}

// class ScheduleRepository {
//   final CalendarRemoteDataSource remote;
//   final ScheduleStorageService localDB;
//
//   ScheduleRepository(this.remote, this.localDB);
//
//   Future<List<Appointment>> getSchedules() async {
//     try {
//       // Try fetching online
//       final data = await remote.fetchSchedules();
//       final appointments = _mapToAppointments(data);
//
//       ///Syncing locally
//       await localDB.saveSchedules(data);
//
//       return appointments;
//     } catch (_) {
//       // If Firestore fails, fallback to local
//       final localData = await localDB.getSchedules();
//       if (localData != null) {
//         return _mapToAppointments(localData);
//       }
//       return []; // No data available
//     }
//   }
//
//   Future<bool> addSchedule(Map<String, dynamic> schedule) async {
//     try {
//       await remote.addSchedule(schedule);
//
//       // Refresh local cache
//       final schedules = await remote.fetchSchedules();
//       await localDB.saveSchedules(schedules);
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   /// Helper method to convert the data to appointment for calendar
//   List<Appointment> _mapToAppointments(List<Map<String, dynamic>> data) {
//     return data.map((item) {
//       return Appointment(
//         startTime: DateTime.parse(item['date']),
//         endTime: DateTime.parse(item['date']).add(const Duration(hours: 1)),
//         subject: "${item['courseName']} (${item['teacherName']})",
//         color: item['isBooked'] ? Colors.grey : Colors.blue,
//       );
//     }).toList();
//   }
// }
