import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final String date; // now stored as "YYYY-MM-DD"
  final bool isBooked;
  final String language;
  final String teacherId;
  final String teacherName;
  final String studentId;
  final String studentName;

  Schedule({
    required this.id,
    required this.date,
    required this.isBooked,
    required this.language,
    required this.teacherId,
    required this.teacherName,
    required this.studentId,
    required this.studentName,
  });

  /// Helper to clean ISO date
  static String cleanDate(String isoDate) {
    return isoDate.split('T')[0]; // keeps only YYYY-MM-DD
  }

  /// Construct from Firestore
  factory Schedule.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Schedule(
      id: doc.id,
      date: cleanDate(data["date"] ?? ""),
      isBooked: data["isBooked"] ?? false,
      language: data["language"] ?? "",
      teacherId: data["teacherId"] ?? "",
      teacherName: data["teacherName"] ?? "",
      studentId: data['studentId'] ?? "",
      studentName: data['studentName'] ?? "",
    );
  }

  /// Construct from Map (local JSON decode)
  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map["id"] ?? "",
      date: cleanDate(map["date"] ?? ""),
      isBooked: map["isBooked"] ?? false,
      language: map["language"] ?? "",
      teacherId: map["teacherId"] ?? "",
      teacherName: map["teacherName"] ?? "",
      studentId: map['studentId'] ?? "",
      studentName: map["studentName"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date, // already clean
      "isBooked": isBooked,
      "language": language,
      "teacherId": teacherId,
      "teacherName": teacherName,
      "studentId": studentId,
      'studentName': studentName,
    };
  }
}

// class Schedule {
//   final String id;
//   final String date; // stored as String in Firestore
//   final bool isBooked;
//   final String language;
//   final String teacherId;
//   final String teacherName;
//   final String studentId;
//   final String studentName;
//
//   Schedule({
//     required this.id,
//     required this.date,
//     required this.isBooked,
//     required this.language,
//     required this.teacherId,
//     required this.teacherName,
//     required this.studentId,
//     required this.studentName,
//   });
//
//   /// Construct from Firestore
//   factory Schedule.fromDoc(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//
//     return Schedule(
//       id: doc.id,
//       date: data["date"] ?? "",
//       isBooked: data["isBooked"] ?? false,
//       language: data["language"] ?? "",
//       teacherId: data["teacherId"] ?? "",
//       teacherName: data["teacherName"] ?? "",
//       studentId: data['studentId'] ?? "",
//       studentName: data['studentName'] ?? "",
//     );
//   }
//
//   /// Construct from Map (local JSON decode)
//   factory Schedule.fromMap(Map<String, dynamic> map) {
//     return Schedule(
//       id: map["id"] ?? "",
//       date: map["date"] ?? "",
//       isBooked: map["isBooked"] ?? false,
//       language: map["language"] ?? "",
//       teacherId: map["teacherId"] ?? "",
//       teacherName: map["teacherName"] ?? "",
//       studentId: map['studentId'] ?? "",
//       studentName: map["studentName"] ?? "",
//     );
//   }
//
//   /// Convert to Map (for saving in SharedPreferences)
//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "date": date,
//       "isBooked": isBooked,
//       "language": language,
//       "teacherId": teacherId,
//       "teacherName": teacherName,
//       "studentId": studentId,
//       'studentName': studentName
//     };
//   }
//
//   @override
//   String toString() {
//     return "Schedule(id: $id, date: $date, isBooked: $isBooked, language: $language, teacherId: $teacherId, teacherName: $teacherName, studentName: $studentName, studentId: $studentId)";
//   }
// }

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
