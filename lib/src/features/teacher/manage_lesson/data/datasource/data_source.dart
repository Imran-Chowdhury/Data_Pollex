import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/language_model.dart';

final manageLessonDataSourceProvider = Provider((ref) {
  return ManageLessonsRemoteDataSource(
      FirebaseAuth.instance, FirebaseFirestore.instance);
});

class ManageLessonsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore _db;
  ManageLessonsRemoteDataSource(this.auth, this._db);

  Future<List<TeacherLanguage>> fetchLanguages(String teacherId) async {
    final snapshot = await _db
        .collection("teacher_languages")
        .where("teacherId", isEqualTo: teacherId)
        .get();

    return snapshot.docs
        .map((doc) => TeacherLanguage.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addLanguage(String teacherId, String language) async {
    final docRef = _db.collection("teacher_languages").doc();
    final lang = TeacherLanguage(
        id: docRef.id, teacherId: teacherId, language: language);

    await docRef.set(lang.toMap());
  }
}
