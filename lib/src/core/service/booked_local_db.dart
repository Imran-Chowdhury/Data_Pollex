import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/student/teacher_date/data/model/schedule_model.dart';

final localBookingDsProvider = Provider((ref) {
  return LocalScheduleDataSource();
});

class LocalScheduleDataSource {
  static const _bookedSchedulesKey = 'booked_schedules';

  /// Save or replace all schedules for a specific language
  Future<void> saveBooking({
    required String language,
    required List<Schedule> schedules,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Load existing map (language -> list of schedules)
    final existingJson = prefs.getString(_bookedSchedulesKey);
    Map<String, dynamic> map = existingJson != null
        ? jsonDecode(existingJson) as Map<String, dynamic>
        : {};

    // Replace the list for this language
    map[language] = schedules.map((s) => s.toMap()).toList();

    await prefs.setString(_bookedSchedulesKey, jsonEncode(map));
    log('Local cache after save: $map');
  }

  /// Get schedules for a student and language
  Future<List<Schedule>> getBookings({
    required String studentId,
    required String language,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existingJson = prefs.getString(_bookedSchedulesKey);
    if (existingJson == null) return [];

    final map = jsonDecode(existingJson) as Map<String, dynamic>;
    final list = map[language] as List<dynamic>?;

    if (list == null) return [];

    final schedules =
        list.map((e) => Schedule.fromMap(e as Map<String, dynamic>)).toList();

    return schedules.where((s) => s.studentId == studentId).toList();
  }

  /// Clear all cached schedules
  Future<void> clearBookings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bookedSchedulesKey);
  }
}

// class LocalScheduleDataSource {
//   static const _bookedSchedulesKey = 'booked_schedules';
//
//   Future<void> saveBooking(Map<String, dynamic> booking) async {
//     final prefs = await SharedPreferences.getInstance();
//     final existing = prefs.getStringList(_bookedSchedulesKey) ?? [];
//     existing.add(jsonEncode(booking));
//     log('local data is $existing');
//     await prefs.setStringList(_bookedSchedulesKey, existing);
//   }
//
//   Future<List<Schedule>> getBookings({
//     required String studentId,
//     required String language,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final existing = prefs.getStringList(_bookedSchedulesKey) ?? [];
//     final decoded =
//         existing.map((e) => Schedule.fromMap(jsonDecode(e))).toList();
//
//     return decoded
//         .where((s) => s.studentId == studentId && s.language == language)
//         .toList();
//   }
//
//   Future<void> clearBookings() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_bookedSchedulesKey);
//   }
// }
