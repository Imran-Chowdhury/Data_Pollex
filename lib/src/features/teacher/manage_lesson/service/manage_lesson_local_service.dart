import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/language_model.dart';

final manageLessonServiceProvider = Provider((ref) {
  return ManageLessonsLocalService();
});

class ManageLessonsLocalService {
  static const _key = "teacher_languages";

  /// Save the entire map of teacherId -> languages
  Future<void> saveTeacherLanguages(Map<String, List<String>> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    await prefs.setString(_key, jsonString);
  }

  /// Load the full map
  Future<Map<String, List<String>>> loadTeacherLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return {};

    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;

    return decoded.map((key, value) => MapEntry(key, List<String>.from(value)));
  }

  /// Fetch languages for a specific teacher
  Future<List<String>> fetchLanguages(String teacherId) async {
    final all = await loadTeacherLanguages();
    return all[teacherId] ?? [];
  }

  /// Add a language to a teacher
  Future<void> addLanguage(String teacherId, String language) async {
    final current = await loadTeacherLanguages();
    final langs = current[teacherId] ?? [];

    if (!langs.contains(language)) {
      langs.add(language);
    }

    current[teacherId] = langs;
    await saveTeacherLanguages(current);
  }

  /// Remove a language from a teacher
  Future<void> removeLanguage(String teacherId, String language) async {
    final current = await loadTeacherLanguages();
    final langs = current[teacherId] ?? [];

    if (langs.contains(language)) {
      langs.remove(language);
      current[teacherId] = langs;
      await saveTeacherLanguages(current);
    }
  }
}

// class ManageLessonsLocalService {
//   static const _key = "teacher_languages";
//
//   Future<void> saveLanguages(List<TeacherLanguage> langs) async {
//     final prefs = await SharedPreferences.getInstance();
//     final list = langs.map((e) => jsonEncode(e.toMap())).toList();
//     await prefs.setStringList(_key, list);
//   }
//
//   Future<List<TeacherLanguage>> loadLanguages() async {
//     final prefs = await SharedPreferences.getInstance();
//     final list = prefs.getStringList(_key) ?? [];
//     return list
//         .map((e) =>
//             TeacherLanguage.fromMap(jsonDecode(e), "local_${e.hashCode}"))
//         .toList();
//   }
// }
