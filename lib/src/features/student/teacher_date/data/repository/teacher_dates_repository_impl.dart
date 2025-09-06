import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/core/riverpod/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/service/booked_local_db.dart';
import '../model/schedule_model.dart';

final teachersDateRepoProvider = Provider((ref) {
  return TeacherDatesRepository(
      firestore: ref.read(fireStoreProvider),
      localDataSource: ref.read(localBookingDsProvider));
});

class TeacherDatesRepository {
  final FirebaseFirestore firestore;
  final LocalScheduleDataSource localDataSource;

  TeacherDatesRepository(
      {required this.firestore, required this.localDataSource});

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
      Schedule schedule, String studentName, String studentId) async {
    try {
      await firestore.collection("schedules").doc(schedule.id).update({
        "isBooked": true,
        "studentName": studentName,
        "studentId": studentId
      });
      // Only save locally if Firebase write succeeds
      // await localDataSource.saveBooking({
      //   "teacherName": schedule.teacherName,
      //   "teacherId": schedule.teacherId,
      //   "language": schedule.language,
      //   "date": schedule.date,
      //   "scheduleId": schedule.id,
      //   "studentName": studentName,
      //   "studentId": studentId,
      //   "isBooked": true,
      // });

      await localDataSource.saveBooking(
        language: schedule.language,
        schedules: [schedule],
      );
      log('The repo try block has executed');
      return SuccessResponse(true);
    } on FirebaseException catch (e) {
      log('The repo firebase exception block has executed');
      return FailureResponse('Failed to book schedule');
    } catch (e) {
      log('The repo catch block has executed');
      return FailureResponse("Unexpected error while booking schedule: $e");
    }
  }
}
