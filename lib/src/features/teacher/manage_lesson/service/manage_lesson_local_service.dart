import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/language_model.dart';

final manageLessonServiceProvider = Provider((ref) {
  return ManageLessonsLocalService();
});

class ManageLessonsLocalService {
  static const _key = "teacher_languages";

  Future<void> saveLanguages(List<TeacherLanguage> langs) async {
    final prefs = await SharedPreferences.getInstance();
    final list = langs.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList(_key, list);
  }

  Future<List<TeacherLanguage>> loadLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list
        .map((e) =>
            TeacherLanguage.fromMap(jsonDecode(e), "local_${e.hashCode}"))
        .toList();
  }
}
