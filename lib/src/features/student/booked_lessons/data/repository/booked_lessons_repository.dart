import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/core/riverpod/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/service/booked_local_db.dart';
import '../../../teacher_date/data/model/schedule_model.dart';

final bookedLessonRepoProvider = Provider((ref) {
  return BookedDatesRepository(
    firestore: ref.read(fireStoreProvider),
    localDs: ref.read(localBookingDsProvider),
  );
});

class BookedDatesRepository {
  final FirebaseFirestore firestore;
  final LocalScheduleDataSource localDs;

  BookedDatesRepository({
    required this.firestore,
    required this.localDs,
  });

  /// Fetch schedules for a student and language (one-time)
  Future<Response> getSchedulesOnce(String studentId, String language) async {
    try {
      // Firestore one-time fetch
      final snapshot = await firestore
          .collection("schedules")
          .where("studentId", isEqualTo: studentId)
          .where("language", isEqualTo: language)
          .where("isBooked", isEqualTo: true)
          .get();

      final schedules =
          snapshot.docs.map((doc) => Schedule.fromDoc(doc)).toList();

      log('the schedules are $schedules');

      // Cache locally
      localDs.saveBooking(language: language, schedules: schedules);
      // for (final s in schedules) {
      //   await localDs.saveBooking(s.toMap());
      // }

      return SuccessResponse(schedules);
    } on FirebaseException catch (e) {
      // Fallback to local cache
      final localSchedules =
          await localDs.getBookings(studentId: studentId, language: language);

      if (localSchedules.isNotEmpty) {
        return SuccessResponse(localSchedules);
      } else {
        return FailureResponse("Failed to fetch schedules: ${e.message}");
      }
    } catch (e) {
      return FailureResponse("Unexpected error: $e");
    }
  }
}
