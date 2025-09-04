import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarRemoteProvider = Provider((ref) {
  return CalendarRemoteDataSource();
});

class CalendarRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchSchedules() async {
    final snapshot = await _firestore.collection('schedules').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> addSchedule(Map<String, dynamic> schedule) async {
    await _firestore.collection('schedules').add(schedule);
  }
}
