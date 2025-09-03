import 'package:data_pollex/src/features/teacher/manage_lesson/data/datasource/data_source.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/data/repository/manage_lesson_repository_impl.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/service/manage_lesson_local_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../data/model/language_model.dart';

final manageLessonRepoProvider = Provider((ref) {
  return ManageLessonsRepositoryImpl(
      remote: ref.read(manageLessonDataSourceProvider),
      localDB: ref.read(manageLessonServiceProvider));
});

abstract class ManageLessonsRepository {
  Future<RemoteResponse<List<TeacherLanguage>>> fetchLanguages(
      String teacherId);
  Future<RemoteResponse<void>> addLanguage(String teacherId, String language);
}
