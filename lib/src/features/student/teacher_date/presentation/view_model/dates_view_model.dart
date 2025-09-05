import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fireStoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final schedulesStreamProvider = StreamProvider.autoDispose
    .family<List<Schedule>, ScheduleFilter>((ref, filter) {
  final firestore = ref.read(fireStoreProvider);

  ref.onDispose(() {
    log('Provider disposed');
  });

  log('The language is ${filter.language}');

  return firestore
      .collection("schedules")
      .where("teacherId", isEqualTo: filter.teacherId)
      .where("language", isEqualTo: filter.language)
      .where("isBooked", isEqualTo: false)
      .snapshots()
      .map((snapshot) {
    final data = snapshot.docs.map((doc) => Schedule.fromDoc(doc)).toList();
    // log('The data is ${data.first.language}');
    return data;
  });
});

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

/// simple model
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
    log('The doc id is ${doc.id}');
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

final bookingControllerProvider =
    AutoDisposeAsyncNotifierProvider<BookingController, void>(
  BookingController.new,
);

class BookingController extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {
    // no state initially
  }

  Future<void> bookSchedule(String scheduleId) async {
    state = const AsyncLoading();
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection("schedules").doc(scheduleId).update({
        "isBooked": true,
      });
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
