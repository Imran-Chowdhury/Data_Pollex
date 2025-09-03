import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageLessonsViewModel extends AsyncNotifier<List<TeacherLanguage>> {
  late final ManageLessonsRepository _repo;

  @override
  FutureOr<List<TeacherLanguage>> build() async {
    _repo = ManageLessonsRepository();
    // teacherId should come from auth provider
    final teacherId = "mock_teacher_123";
    return await _repo.fetchLanguages(teacherId);
  }

  Future<void> addLanguage(String teacherId, String language) async {
    final current = state.value ?? [];

    // Check duplicate
    if (current.any((lang) => lang.language == language)) {
      state = AsyncError("Language already added", StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.addLanguage(teacherId, language);
      return await _repo.fetchLanguages(teacherId);
    });
  }
}
