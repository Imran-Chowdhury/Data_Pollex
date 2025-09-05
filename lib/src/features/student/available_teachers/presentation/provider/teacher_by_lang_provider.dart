import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/features/auth/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teachersByLanguageProvider =
    StreamProvider.family.autoDispose<List<UserModel>, String>((ref, language) {
  final firestore = FirebaseFirestore.instance;

  ref.onDispose(() {
    log('provider diposed');
  });
  // Prevent caching

  return firestore
      .collection("teachers_languages")
      .where("languages", arrayContains: language)
      .snapshots()
      .asyncMap((snap) async {
    // For each teacher_languages doc → fetch user doc with same id
    final teachers = await Future.wait(snap.docs.map((doc) async {
      final teacherId = doc.id; // same id as user doc
      final userDoc = await firestore.collection("users").doc(teacherId).get();

      if (!userDoc.exists) return null;

      return UserModel.fromMap(
        userDoc.data() as Map<String, dynamic>,
        userDoc.id,
      );
    }));

    // Filtering out nulls (if user missing)
    return teachers.whereType<UserModel>().toList();
  });
});
