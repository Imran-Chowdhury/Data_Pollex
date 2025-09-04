import 'package:data_pollex/src/features/teacher/manage_schedule/data/repository/calendar_repository_impl.dart';
import 'package:riverpod/riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../manage_lesson/service/manage_lesson_local_service.dart';

class ScheduleController extends AsyncNotifier<List<Appointment>> {
  late final ScheduleRepository _repository;

  @override
  Future<List<Appointment>> build() async {
    _repository = ref.read(scheduleRepositoryProvider);
    // Initial fetch
    return await _repository.getSchedules();
  }

  /// Reload schedules (online → offline fallback)
  Future<void> loadSchedules() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repository.getSchedules();
    });
  }

  /// Add a new schedule (if success → refresh, else keep old state)
  Future<void> addSchedule(Map<String, dynamic> schedule) async {
    state = const AsyncLoading();

    final response = await _repository.addSchedule(schedule);

    if (response is RemoteSuccess<void>) {
      // Remote add succeeded → refresh schedules
      state = await AsyncValue.guard(() async {
        return await _repository.getSchedules();
      });
    } else if (response is RemoteFailure) {
      // Keep old state but mark error with actual message
      state = AsyncError(
        response.message,
        StackTrace.current,
      );
    } else {
      // Fallback unknown error
      state = AsyncError(
        "Unknown error occurred",
        StackTrace.current,
      );
    }
  }
}

// class ScheduleController extends AsyncNotifier<List<Appointment>> {
//   late final ScheduleRepository _repository;
//
//   @override
//   Future<List<Appointment>> build() async {
//     _repository = ref.read(scheduleRepositoryProvider);
//     // Initial fetch
//     return await _repository.getSchedules();
//   }
//
//   /// Reload schedules (online → offline fallback)
//   Future<void> loadSchedules() async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() async {
//       return await _repository.getSchedules();
//     });
//   }
//
//   /// Add a new schedule (if success → refresh, else keep old state)
//   Future<void> addSchedule(Map<String, dynamic> schedule) async {
//     state = const AsyncLoading();
//     final success = await _repository.addSchedule(schedule);
//     if (success) {
//       state = await AsyncValue.guard(() async {
//         return await _repository.getSchedules();
//       });
//     } else {
//       // Keep old state but mark error
//       state = AsyncError("Failed to add schedule", StackTrace.current);
//     }
//   }
// }

/// Provider for the controller
final scheduleControllerProvider =
    AsyncNotifierProvider<ScheduleController, List<Appointment>>(
  () => ScheduleController(),
);

/// Getting the lessons of a teacher
final lessonsProvider = AutoDisposeFutureProvider((ref) async {
  final teacherId = ref.read(authViewModelProvider).user!.id;
  return await ref.read(manageLessonServiceProvider).fetchLanguages(teacherId);
});
