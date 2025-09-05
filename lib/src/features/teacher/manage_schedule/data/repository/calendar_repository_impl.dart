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

    if (response is SuccessResponse<List<Map<String, dynamic>>>) {
      final data = response.data;
      final appointments = _mapToAppointments(data);

      // Sync with local storage
      await localDB.saveSchedules(data);

      return appointments;
    } else if (response is FailureResponse) {
      // fallback to local if Firestore fails
      final localData = await localDB.getSchedules();
      if (localData != null) {
        return _mapToAppointments(localData);
      }
      return []; // nothing available
    }

    return [];
  }

  Future<Response<void>> addSchedule(Map<String, dynamic> schedule) async {
    final response = await remote.addSchedule(schedule);

    if (response is SuccessResponse<void>) {
      // Refresh cache only if remote succeeded
      final fetchResponse = await remote.fetchSchedules();

      if (fetchResponse is SuccessResponse<List<Map<String, dynamic>>>) {
        await localDB.saveSchedules(fetchResponse.data);
      }

      return SuccessResponse(null);
    } else if (response is FailureResponse) {
      return FailureResponse(response.message, statusCode: response.statusCode);
    }

    return FailureResponse("Unknown error occurred");
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
