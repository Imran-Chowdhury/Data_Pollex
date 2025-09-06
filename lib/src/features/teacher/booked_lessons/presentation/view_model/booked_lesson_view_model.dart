import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../../../student/teacher_date/data/model/schedule_model.dart';
import '../../data/repository/teacher_booked_lessons_repository.dart';

class BookedLanguage {
  final String userId;
  final String language;

  const BookedLanguage({required this.userId, required this.language});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookedLanguage &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          language == other.language;

  @override
  int get hashCode => userId.hashCode ^ language.hashCode;
}

final teacherBookedSchedulesProvider = FutureProvider.autoDispose
    .family<List<Schedule>, BookedLanguage>((ref, params) async {
  final repository = ref.read(teacherBookedLessonRepoProvider);
  final response =
      await repository.getSchedulesOnce(params.userId, params.language);

  if (response is Success) {
    log('The response is $response');
    return response.data;
  } else if (response is Failure) {
    log('Failure response');
    throw Exception(response.message);
  }
  return [];
});
