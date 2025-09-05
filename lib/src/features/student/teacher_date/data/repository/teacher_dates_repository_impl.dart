import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/schedule_model.dart';

class TeacherDatesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Schedule>> getSchedules(String teacherId, String language) {
    return _db
        .collection("schedules")
        .where("teacherId", isEqualTo: teacherId)
        .where("language", isEqualTo: language)
        .where("isBooked", isEqualTo: false)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => Schedule.fromFirestore(doc)).toList());
  }

  Future<void> bookSchedule(String id) async {
    await _db.collection("schedules").doc(id).update({"isBooked": true});
  }
}
