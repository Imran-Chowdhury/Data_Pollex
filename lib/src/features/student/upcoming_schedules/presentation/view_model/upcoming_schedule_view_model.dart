import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/riverpod/firestore_provider.dart';
import '../../../../auth/presentation/providers/auth_providers.dart';

final studentScheduleProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final firestore = ref.read(fireStoreProvider); // Firestore service
  final studentId = ref
      .read(authViewModelProvider)
      .user!
      .id; // Get student ID from auth provider

  try {
    // Fetch the schedules for the given student where isBooked is true
    final snapshot = await firestore
        .collection("schedules")
        .where("studentId", isEqualTo: studentId)
        .where("isBooked", isEqualTo: true)
        .get();

    final schedules = snapshot.docs.map((doc) => doc.data()).where((schedule) {
      // Convert the date string to DateTime and compare with today's date
      final scheduleDate = DateTime.parse(schedule['date']);
      final now = DateTime.now();
      return scheduleDate.isAfter(now) ||
          isSameDay(scheduleDate, now); // Only show today and future dates
    }).toList();

    return schedules; // Return the filtered schedules
  } catch (e) {
    print("Error fetching schedules: $e");
    return []; // Return an empty list if an error occurs
  }
});

// Helper function to check if two dates are the same day
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
