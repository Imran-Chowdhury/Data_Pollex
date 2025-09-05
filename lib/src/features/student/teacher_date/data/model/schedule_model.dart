import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final DateTime date;
  final bool isBooked;
  final String language;
  final String teacherId;
  final String teacherName;

  Schedule({
    required this.id,
    required this.date,
    required this.isBooked,
    required this.language,
    required this.teacherId,
    required this.teacherName,
  });

  factory Schedule.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Schedule(
      id: doc.id,
      date: DateTime.parse(data['date']),
      isBooked: data['isBooked'] ?? false,
      language: data['language'] ?? '',
      teacherId: data['teacherId'] ?? '',
      teacherName: data['teacherName'] ?? '',
    );
  }
}
