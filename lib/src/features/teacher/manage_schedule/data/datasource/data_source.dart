import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/remote_response.dart';

final calendarRemoteProvider = Provider((ref) {
  return CalendarRemoteDataSource();
});

class CalendarRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<Response<List<Map<String, dynamic>>>> fetchSchedules(
      String teacherId) async {
    try {
      final snapshot = await _firestore
          .collection('schedules')
          .where('teacherId', isEqualTo: teacherId)
          .get();
      final schedules = snapshot.docs.map((doc) => doc.data()).toList();
      return SuccessResponse(schedules);
    } catch (e) {
      return FailureResponse("Failed to fetch schedules: $e");
    }
  }

  Future<Response<void>> addSchedule(Map<String, dynamic> schedule) async {
    try {
      final String language = schedule['language'];
      final String date = schedule['date']; // make sure you store consistently

      final query = await _firestore
          .collection('schedules')
          .where('language', isEqualTo: language)
          .where('date', isEqualTo: date)
          .get();

      if (query.docs.isEmpty) {
        await _firestore.collection('schedules').add(schedule);
        return SuccessResponse(null);
      } else {
        return FailureResponse(
          'Schedule for $language on $date already exists.',
          statusCode: 409, // conflict
        );
      }
    } catch (e) {
      return FailureResponse("Failed to add schedule: $e");
    }
  }
}

// class CalendarRemoteDataSource {
//   final _firestore = FirebaseFirestore.instance;
//
//   Future<List<Map<String, dynamic>>> fetchSchedules() async {
//     final snapshot = await _firestore.collection('schedules').get();
//     return snapshot.docs.map((doc) => doc.data()).toList();
//   }
//
//   Future<void> addSchedule(Map<String, dynamic> schedule) async {
//     final String language = schedule['language'];
//     final String date =
//         schedule['date']; // store as string or Timestamp consistently
//
//     final query = await _firestore
//         .collection('schedules')
//         .where('language', isEqualTo: language)
//         .where('date', isEqualTo: date)
//         .get();
//
//     if (query.docs.isEmpty) {
//       // No duplicate found, safe to add
//       await _firestore.collection('schedules').add(schedule);
//     } else {
//       // Duplicate found, handle accordingly
//       throw Exception('Schedule for $language on $date already exists.');
//     }
//   }
// }
