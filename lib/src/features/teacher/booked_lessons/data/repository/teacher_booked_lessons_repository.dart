import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/core/riverpod/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/service/booked_local_db.dart';
import '../../../../student/teacher_date/data/model/schedule_model.dart';

final teacherBookedLessonRepoProvider = Provider((ref) {
  return TeacherBookedDatesRepository(
    firestore: ref.read(fireStoreProvider),
    localDs: ref.read(localBookingDsProvider),
  );
});

class TeacherBookedDatesRepository {
  final FirebaseFirestore firestore;
  final LocalScheduleDataSource localDs;

  TeacherBookedDatesRepository({
    required this.firestore,
    required this.localDs,
  });

  /// Fetch schedules for a student and language (one-time)
  Future<DataResponse> getSchedulesOnce(
      String teacherId, String language) async {
    try {
      // Firestore one-time fetch
      final snapshot = await firestore
          .collection("schedules")
          .where("teacherId", isEqualTo: teacherId)
          .where("language", isEqualTo: language)
          .where("isBooked", isEqualTo: true)
          .get();

      final schedules =
          snapshot.docs.map((doc) => Schedule.fromDoc(doc)).toList();

      log('the schedules are $schedules');

      // Cache locally
      localDs.saveBooking(
          language: language, schedules: schedules, userType: 'Teacher');
      // for (final s in schedules) {
      //   await localDs.saveBooking(s.toMap());
      // }

      return Success(schedules);
    } on FirebaseException catch (e) {
      // Fallback to local cache
      final localSchedules = await localDs.getBookings(
          userId: teacherId, language: language, userType: 'Teacher');

      if (localSchedules.isNotEmpty) {
        return Success(localSchedules);
      } else {
        return Failure("Failed to fetch schedules: ${e.message}");
      }
    } catch (e) {
      return Failure("Unexpected error: $e");
    }
  }
}
