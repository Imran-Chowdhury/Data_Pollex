import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../../teacher_date/data/model/schedule_model.dart';
import '../../data/repository/booked_lessons_repository.dart';

class StudentLanguage {
  final String studentId;
  final String language;

  const StudentLanguage({required this.studentId, required this.language});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentLanguage &&
          runtimeType == other.runtimeType &&
          studentId == other.studentId &&
          language == other.language;

  @override
  int get hashCode => studentId.hashCode ^ language.hashCode;
}

final bookedSchedulesProvider = FutureProvider.autoDispose
    .family<List<Schedule>, StudentLanguage>((ref, params) async {
  final repository = ref.read(bookedLessonRepoProvider);
  final response =
      await repository.getSchedulesOnce(params.studentId, params.language);

  if (response is SuccessResponse) {
    log('The response is $response');
    return response.data;
  } else if (response is FailureResponse) {
    log('Failure response');
    throw Exception(response.message);
  }
  return [];
});
