import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/student/teacher_date/data/model/schedule_model.dart';

final localBookingDsProvider = Provider((ref) {
  return LocalScheduleDataSource();
});

class LocalScheduleDataSource {
  static const _studentKey = 'student_booked_schedules';
  static const _teacherKey = 'teacher_booked_schedules';

  // static const _bookedSchedulesKey = 'booked_schedules';

  /// Save or replace all schedules for a specific language
  Future<void> saveBooking({
    required String language,
    required List<Schedule> schedules,
    required String userType,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Load existing map (language -> list of schedules)
    final existingJson =
        prefs.getString(userType == 'Teacher' ? _teacherKey : _studentKey);
    Map<String, dynamic> map = existingJson != null
        ? jsonDecode(existingJson) as Map<String, dynamic>
        : {};

    // Replace the list for this language
    map[language] = schedules.map((s) => s.toMap()).toList();

    await prefs.setString(
        userType == 'Teacher' ? _teacherKey : _studentKey, jsonEncode(map));
    log('Local cache after save: $map');
  }

  /// Get schedules for a student and language
  Future<List<Schedule>> getBookings({
    required String userId,
    required String language,
    required String userType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existingJson =
        prefs.getString(userType == 'Teacher' ? _teacherKey : _studentKey);
    if (existingJson == null) return [];

    final map = jsonDecode(existingJson) as Map<String, dynamic>;
    final list = map[language] as List<dynamic>?;

    if (list == null) return [];

    final schedules =
        list.map((e) => Schedule.fromMap(e as Map<String, dynamic>)).toList();

    return userType == 'Teacher'
        ? schedules.where((s) => s.teacherId == userId).toList()
        : schedules.where((s) => s.studentId == userId).toList();
  }

  // /// Clear all cached schedules
  // Future<void> clearBookings() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_studentKey);
  // }
}
