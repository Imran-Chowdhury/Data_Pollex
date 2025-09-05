import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final String date;
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

  factory Schedule.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Schedule(
      id: doc.id,
      date: data["date"],
      isBooked: data["isBooked"] as bool,
      language: data["language"] ?? "",
      teacherId: data["teacherId"] ?? "",
      teacherName: data["teacherName"] ?? "",
    );
  }
}

/// Filter for passing as arg in the Stream Family Provider
class ScheduleFilter {
  final String teacherId;
  final String language;

  const ScheduleFilter({required this.teacherId, required this.language});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleFilter &&
          runtimeType == other.runtimeType &&
          teacherId == other.teacherId &&
          language == other.language;

  @override
  int get hashCode => teacherId.hashCode ^ language.hashCode;
}
