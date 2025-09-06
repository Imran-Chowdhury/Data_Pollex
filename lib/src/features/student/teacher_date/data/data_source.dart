// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'model/schedule_model.dart';
//
//
// class BookingRemoteDataSource {
//   final FirebaseFirestore firestore;
//
//   BookingRemoteDataSource({required this.firestore});
//
//   Future<void> bookScheduleRemote({
//     required String scheduleId,
//     required String studentName,
//     required String studentId,
//   }) async {
//     await firestore.collection("schedules").doc(scheduleId).update({
//       "isBooked": true,
//       "studentName": studentName,
//       "studentId": studentId,
//     });
//   }
//
//   Stream<List<Schedule>> getBookedSchedulesRemote({
//     required String studentId,
//     required String language,
//   }) {
//     return firestore
//         .collection("schedules")
//         .where("studentId", isEqualTo: studentId)
//         .where("language", isEqualTo: language)
//         .where("isBooked", isEqualTo: true)
//         .snapshots()
//         .map((snapshot) =>
//         snapshot.docs.map((doc) => Schedule.fromDoc(doc)).toList());
//   }
// }
