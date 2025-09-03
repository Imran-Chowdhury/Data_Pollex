import 'dart:async';

import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/domain/repository/manage_lesson_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../data/model/language_model.dart';

final manageLessonsProvider =
    AsyncNotifierProvider<ManageLessonsViewModel, List<TeacherLanguage>>(
        () => ManageLessonsViewModel());

class ManageLessonsViewModel extends AsyncNotifier<List<TeacherLanguage>> {
  late final ManageLessonsRepository _repo;

  @override
  Future<List<TeacherLanguage>> build() async {
    _repo = ref.read(manageLessonRepoProvider);
    final teacherId = ref.read(authViewModelProvider).user!.id;

    final res = await _repo.fetchLanguages(teacherId);
    if (res is RemoteSuccess<List<TeacherLanguage>>) {
      return res.data;
    } else {
      throw Exception((res as RemoteFailure).message);
    }
  }

  Future<void> addLanguage(String teacherId, String language) async {
    final res = await _repo.addLanguage(teacherId, language);

    if (res is RemoteFailure) {
      state = AsyncError(res.message, StackTrace.current);
    } else {
      // Refresh list
      final refreshed = await _repo.fetchLanguages(teacherId);
      if (refreshed is RemoteSuccess<List<TeacherLanguage>>) {
        state = AsyncData(refreshed.data);
      }
    }
  }
}
