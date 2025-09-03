import 'package:data_pollex/src/features/teacher/manage_lesson/domain/repository/manage_lesson_repository.dart';

import '../../../../../core/base_state/remote_response.dart';
import '../../service/manage_lesson_local_service.dart';
import '../datasource/data_source.dart';
import '../model/language_model.dart';

class ManageLessonsRepositoryImpl implements ManageLessonsRepository {
  final ManageLessonsRemoteDataSource remote;
  final ManageLessonsLocalService localDB;

  ManageLessonsRepositoryImpl({required this.remote, required this.localDB});

  @override
  Future<RemoteResponse<List<TeacherLanguage>>> fetchLanguages(
      String teacherId) async {
    try {
      final langs = await remote.fetchLanguages(teacherId);

      // Cache offline
      await localDB.saveLanguages(langs);

      return RemoteSuccess(langs);
    } catch (e) {
      // Offline fallback
      final local = await localDB.loadLanguages();
      if (local.isNotEmpty) {
        return RemoteSuccess(local);
      }
      return RemoteFailure("Failed to fetch languages: $e");
    }
  }

  @override
  Future<RemoteResponse<void>> addLanguage(
      String teacherId, String language) async {
    try {
      await remote.addLanguage(teacherId, language);

      // Refresh & update local
      final langs = await remote.fetchLanguages(teacherId);
      await localDB.saveLanguages(langs);

      return RemoteSuccess(null);
    } catch (e) {
      return RemoteFailure("Failed to add language: $e");
    }
  }
}

// class ManageLessonsRepositoryImpl implements ManageLessonsRepository {
//   final _db = FirebaseFirestore.instance;
//   final _local = ManageLessonsLocalService();
//
//   @override
//   Future<List<TeacherLanguage>> fetchLanguages(String teacherId) async {
//     try {
//       final snapshot = await _db
//           .collection("teacher_languages")
//           .where("teacherId", isEqualTo: teacherId)
//           .get();
//
//       final langs = snapshot.docs
//           .map((doc) => TeacherLanguage.fromMap(doc.data(), doc.id))
//           .toList();
//
//       // Save offline
//       await _local.saveLanguages(langs);
//
//       return langs;
//     } catch (e) {
//       // If offline → load from local
//       return await _local.loadLanguages();
//     }
//   }
//
//   @override
//   Future<void> addLanguage(String teacherId, String language) async {
//     final docRef = _db.collection("teacher_languages").doc();
//     final lang = TeacherLanguage(
//         id: docRef.id, teacherId: teacherId, language: language);
//     await docRef.set(lang.toMap());
//
//     // Update local cache as well
//     final langs = await fetchLanguages(teacherId);
//     await _local.saveLanguages(langs);
//   }
// }
