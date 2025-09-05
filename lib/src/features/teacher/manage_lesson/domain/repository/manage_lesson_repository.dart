import 'package:data_pollex/src/features/teacher/manage_lesson/data/datasource/data_source.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/data/repository/manage_lesson_repository_impl.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/service/manage_lesson_local_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';

final manageLessonRepoProvider = Provider((ref) {
  return ManageLessonsRepositoryImpl(
      remote: ref.read(manageLessonDataSourceProvider),
      localDB: ref.read(manageLessonServiceProvider));
});

abstract class ManageLessonsRepository {
  Future<Response<List<String>>> fetchLanguages(String teacherId);
  Future<Response<void>> addLanguage(String teacherId, String language);
  Future<Response<void>> removeLanguage(String teacherId, String language);
}
