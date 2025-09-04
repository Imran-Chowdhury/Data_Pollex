import 'dart:async';

import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/domain/repository/manage_lesson_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../data/model/language_model.dart';

final manageLessonsProvider =
    AutoDisposeAsyncNotifierProvider<ManageLessonsViewModel, List<String>>(
        () => ManageLessonsViewModel());

class ManageLessonsViewModel extends AutoDisposeAsyncNotifier<List<String>> {
  late final ManageLessonsRepository _repo;

  @override
  Future<List<String>> build() async {
    _repo = ref.read(manageLessonRepoProvider);
    final teacherId = ref.read(authViewModelProvider).user!.id;

    try {
      final res = await _repo.fetchLanguages(teacherId);

      if (res is RemoteSuccess<List<String>>) {
        return res.data;
      } else if (res is RemoteFailure<List<String>>) {
        // Return empty list on failure
        return [];
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  Future<void> addLanguage(String teacherId, String language) async {
    // Set loading state while adding
    state = const AsyncValue.loading();

    final res = await _repo.addLanguage(teacherId, language);

    if (res is RemoteFailure) {
      state = AsyncValue.error(res.message, StackTrace.current);
    } else if (res is RemoteSuccess<void>) {
      // Refresh list after successful add
      final refreshed = await _repo.fetchLanguages(teacherId);
      if (refreshed is RemoteSuccess<List<String>>) {
        state = AsyncValue.data(refreshed.data);
      } else if (refreshed is RemoteFailure<List<String>>) {
        state = AsyncValue.error(refreshed.message, StackTrace.current);
      } else {
        state = AsyncValue.error("Unknown error", StackTrace.current);
      }
    }
  }

  Future<void> removeLanguage(String teacherId, String language) async {
    state = const AsyncValue.loading();

    final res = await _repo.removeLanguage(teacherId, language);

    if (res is RemoteFailure) {
      state = AsyncValue.error(res.message, StackTrace.current);
    } else if (res is RemoteSuccess<void>) {
      // Refresh list after removal
      final refreshed = await _repo.fetchLanguages(teacherId);
      if (refreshed is RemoteSuccess<List<String>>) {
        state = AsyncValue.data(refreshed.data);
      } else if (refreshed is RemoteFailure<List<String>>) {
        state = AsyncValue.error(refreshed.message, StackTrace.current);
      } else {
        state = AsyncValue.error("Unknown error", StackTrace.current);
      }
    }
  }
}

// class ManageLessonsViewModel extends AsyncNotifier<List<TeacherLanguage>> {
//   late final ManageLessonsRepository _repo;
//
//   @override
//   Future<List<TeacherLanguage>> build() async {
//     _repo = ref.read(manageLessonRepoProvider);
//     final teacherId = ref.read(authViewModelProvider).user!.id;
//
//     final res = await _repo.fetchLanguages(teacherId);
//     if (res is RemoteSuccess<List<TeacherLanguage>>) {
//       return res.data;
//     } else {
//       throw Exception((res as RemoteFailure).message);
//     }
//   }
//
//   Future<void> addLanguage(String teacherId, String language) async {
//     final res = await _repo.addLanguage(teacherId, language);
//
//     if (res is RemoteFailure) {
//       state = AsyncError(res.message, StackTrace.current);
//     } else {
//       // Refresh list
//       final refreshed = await _repo.fetchLanguages(teacherId);
//       if (refreshed is RemoteSuccess<List<TeacherLanguage>>) {
//         state = AsyncData(refreshed.data);
//       }
//     }
//   }
// }
