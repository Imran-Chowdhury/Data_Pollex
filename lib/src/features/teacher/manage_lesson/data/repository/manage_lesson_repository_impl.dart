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
  Future<RemoteResponse<List<String>>> fetchLanguages(String teacherId) async {
    try {
      final remoteResponse = await remote.fetchLanguages(teacherId);

      if (remoteResponse is RemoteSuccess<List<String>>) {
        // Cache locally
        await localDB.addLanguage(teacherId, ""); // No-op to ensure map exists
        final langs = remoteResponse.data;
        await localDB.saveTeacherLanguages({teacherId: langs});
        return RemoteSuccess(langs);
      } else if (remoteResponse is RemoteFailure) {
        final local = await localDB.fetchLanguages(teacherId);
        if (local.isNotEmpty) return RemoteSuccess(local);

        return RemoteFailure('Could not find any lesson');
      }

      return RemoteFailure("Unknown error while fetching languages");
    } catch (e) {
      final local = await localDB.fetchLanguages(teacherId);
      if (local.isNotEmpty) return RemoteSuccess(local);
      return RemoteFailure("Failed to fetch languages: $e");
    }
  }

  @override
  Future<RemoteResponse<void>> addLanguage(
      String teacherId, String language) async {
    try {
      final remoteResponse = await remote.addLanguage(teacherId, language);

      if (remoteResponse is RemoteSuccess<void>) {
        await localDB.addLanguage(teacherId, language);
        return RemoteSuccess(null);
      } else if (remoteResponse is RemoteFailure) {
        return RemoteFailure(remoteResponse.message);
      }

      return RemoteFailure("Unknown error while adding language");
    } catch (e) {
      return RemoteFailure("Failed to add language: $e");
    }
  }

  @override
  Future<RemoteResponse<void>> removeLanguage(
      String teacherId, String language) async {
    try {
      final remoteResponse = await remote.removeLanguage(teacherId, language);

      if (remoteResponse is RemoteSuccess<void>) {
        await localDB.removeLanguage(teacherId, language);
        return RemoteSuccess(null);
      } else if (remoteResponse is RemoteFailure) {
        return RemoteFailure(remoteResponse.message);
      }

      return RemoteFailure("Unknown error while removing language");
    } catch (e) {
      return RemoteFailure("Failed to remove language: $e");
    }
  }
}

// class ManageLessonsRepositoryImpl implements ManageLessonsRepository {
//   final ManageLessonsRemoteDataSource remote;
//   final ManageLessonsLocalService localDB;
//
//   ManageLessonsRepositoryImpl({required this.remote, required this.localDB});
//
//   @override
//   Future<RemoteResponse<List<TeacherLanguage>>> fetchLanguages(
//       String teacherId) async {
//     try {
//       final langs = await remote.fetchLanguages(teacherId);
//
//       // Cache offline
//       await localDB.saveLanguages(langs);
//
//       return RemoteSuccess(langs);
//     } catch (e) {
//       // Offline fallback
//       final local = await localDB.loadLanguages();
//       if (local.isNotEmpty) {
//         return RemoteSuccess(local);
//       }
//       return RemoteFailure("Failed to fetch languages: $e");
//     }
//   }
//
//   @override
//   Future<RemoteResponse<void>> addLanguage(
//       String teacherId, String language) async {
//     try {
//       await remote.addLanguage(teacherId, language);
//
//       // Refresh & update local
//       final langs = await remote.fetchLanguages(teacherId);
//       await localDB.saveLanguages(langs);
//
//       return RemoteSuccess(null);
//     } catch (e) {
//       return RemoteFailure("Failed to add language: $e");
//     }
//   }
// }
