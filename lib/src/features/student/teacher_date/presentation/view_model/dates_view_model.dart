import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/features/student/teacher_date/data/repository/teacher_dates_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/schedule_model.dart';

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
  late final TeacherDatesRepository repository =
      ref.read(teachersDateRepoProvider);
  @override
  Future<void> build() async {
    // no state initially
  }

  Future<void> bookSchedule(
      Schedule schedule, String studentName, String studentId) async {
    state = const AsyncLoading();
    try {
      final res =
          await repository.bookSchedule(schedule, studentName, studentId);
      if (res is Success) {
        state = const AsyncData(null);
      } else if (res is Failure) {
        state = AsyncError(res.message, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
