import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/features/student/teacher_date/data/repository/teacher_dates_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/schedule_model.dart';

// final schedulesStreamProvider = StreamProvider.autoDispose
//     .family<List<Schedule>, ScheduleFilter>((ref, filter) {
//   final firestore = ref.read(fireStoreProvider);
//
//   return firestore
//       .collection("schedules")
//       .where("teacherId", isEqualTo: filter.teacherId)
//       .where("language", isEqualTo: filter.language)
//       .where("isBooked", isEqualTo: false)
//       .snapshots()
//       .map((snapshot) {
//     final data = snapshot.docs.map((doc) => Schedule.fromDoc(doc)).toList();
//
//     return data;
//   });
// });

/// Stream listens to the list of dates
final schedulesStreamProvider = StreamProvider.autoDispose
    .family<List<Schedule>, ScheduleFilter>((ref, filter) {
  final repository = ref.read(teachersDateRepoProvider);

  return repository.getSchedules(
      teacherId: filter.teacherId, language: filter.language);
});

/// Controller for handling booking
final bookingControllerProvider =
    AutoDisposeAsyncNotifierProvider<BookingController, void>(
  BookingController.new,
);

class BookingController extends AutoDisposeAsyncNotifier<void> {
  late final TeacherDatesRepositoryImpl repository =
      ref.read(teachersDateRepoProvider);
  @override
  Future<void> build() async {
    // no state initially
  }

  Future<void> bookSchedule(
      String scheduleId, String studentName, String studentId) async {
    state = const AsyncLoading();
    try {
      final res =
          await repository.bookSchedule(scheduleId, studentName, studentId);
      if (res is SuccessResponse) {
        state = const AsyncData(null);
      } else if (res is FailureResponse) {
        state = AsyncError(res.message, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

// class BookingController extends AutoDisposeAsyncNotifier<void> {
//   @override
//   Future<void> build() async {
//     // no state initially
//   }
//
//   Future<void> bookSchedule(String scheduleId) async {
//     state = const AsyncLoading();
//     try {
//       final firestore = FirebaseFirestore.instance;
//       await firestore.collection("schedules").doc(scheduleId).update({
//         "isBooked": true,
//       });
//       state = const AsyncData(null);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
// }
