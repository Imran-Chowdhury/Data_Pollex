import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/core/riverpod/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/schedule_model.dart';

final teachersDateRepoProvider = Provider((ref) {
  return TeacherDatesRepositoryImpl(
    firestore: ref.read(fireStoreProvider),
  );
});

class TeacherDatesRepositoryImpl {
  final FirebaseFirestore firestore;

  TeacherDatesRepositoryImpl({required this.firestore});

  /// Fetch schedules for a teacher and language
  Stream<List<Schedule>> getSchedules({
    required String teacherId,
    required String language,
  }) {
    try {
      return firestore
          .collection("schedules")
          .where("teacherId", isEqualTo: teacherId)
          .where("language", isEqualTo: language)
          .where("isBooked", isEqualTo: false)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Schedule.fromDoc(doc)).toList());
    } on FirebaseException catch (e) {
      // Wrap Firebase exception in a stream error
      return Stream.error("Failed to fetch schedules: ${e.message}");
    } catch (e) {
      // Any other unexpected error
      return Stream.error("Unexpected error: $e");
    }
  }

  /// Book a schedule
  Future<Response> bookSchedule(
      String scheduleId, String studentName, String studentId) async {
    try {
      await firestore.collection("schedules").doc(scheduleId).update({
        "isBooked": true,
        "studentName": studentName,
        "studentId": studentId
      });
      return SuccessResponse(true);
    } on FirebaseException catch (e) {
      return FailureResponse('Failed to book schedule');
    } catch (e) {
      return FailureResponse("Unexpected error while booking schedule: $e");
    }
  }
}
