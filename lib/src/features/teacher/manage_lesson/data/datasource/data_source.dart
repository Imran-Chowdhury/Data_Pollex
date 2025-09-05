import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';

final manageLessonDataSourceProvider = Provider((ref) {
  return ManageLessonsRemoteDataSource(
      FirebaseAuth.instance, FirebaseFirestore.instance);
});

class ManageLessonsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore _db;

  ManageLessonsRemoteDataSource(this.auth, this._db);

  Future<Response<List<String>>> fetchLanguages(String teacherId) async {
    try {
      final doc =
          await _db.collection("teachers_languages").doc(teacherId).get();
      if (!doc.exists) return SuccessResponse([]);

      final data = doc.data();
      final langs = data != null && data["languages"] != null
          ? List<String>.from(data["languages"])
          : <String>[];

      return SuccessResponse(langs);
    } catch (e) {
      return FailureResponse("Failed to fetch languages: $e");
    }
  }

  Future<Response<void>> addLanguage(String teacherId, String language) async {
    try {
      final docRef = _db.collection("teachers_languages").doc(teacherId);

      // Get current document
      final doc = await docRef.get();

      if (doc.exists) {
        final data = doc.data();
        final languages = data != null && data["languages"] != null
            ? List<String>.from(data["languages"])
            : <String>[];

        if (languages.contains(language)) {
          return FailureResponse("This language is already present");
        }
      }

      // Add the language if not present
      await docRef.set(
        {
          "languages": FieldValue.arrayUnion([language])
        },
        SetOptions(merge: true),
      );

      return SuccessResponse(null);
    } catch (e) {
      return FailureResponse("Failed to add language: $e");
    }
  }

  Future<Response<void>> removeLanguage(
      String teacherId, String language) async {
    try {
      final docRef = _db.collection("teachers_languages").doc(teacherId);

      await docRef.update({
        "languages": FieldValue.arrayRemove([language])
      });

      return SuccessResponse(null);
    } catch (e) {
      return FailureResponse("Failed to remove language: $e");
    }
  }
}

// class ManageLessonsRemoteDataSource {
//   final FirebaseAuth auth;
//   final FirebaseFirestore _db;
//   ManageLessonsRemoteDataSource(this.auth, this._db);
//
//   Future<List<TeacherLanguage>> fetchLanguages(String teacherId) async {
//     final snapshot = await _db
//         .collection("teacher_languages")
//         .where("teacherId", isEqualTo: teacherId)
//         .get();
//
//     return snapshot.docs
//         .map((doc) => TeacherLanguage.fromMap(doc.data(), doc.id))
//         .toList();
//   }
//
//   Future<void> addLanguage(String teacherId, String language) async {
//     final docRef = _db.collection("teacher_languages").doc();
//     final lang = TeacherLanguage(
//         id: docRef.id, teacherId: teacherId, language: language);
//
//     await docRef.set(lang.toMap());
//   }
// }
