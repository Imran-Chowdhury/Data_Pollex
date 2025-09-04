import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final calendarLocalProvider = Provider((ref){
  return ScheduleStorageService();
});
class ScheduleStorageService {
  static const _key = 'appointments';

  Future<void> saveSchedules(List<Map<String, dynamic>> schedules) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(schedules));
  }

  Future<List<Map<String, dynamic>>?> getSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString(_key);
    if (storedData == null) return null;
    return List<Map<String, dynamic>>.from(jsonDecode(storedData));
  }
}
