import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_state/payment_state.dart';
import '../../../../../core/utils/color.dart';
import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../../stripe/presentation/view_model/stripe_view_model.dart';
import '../../../../video_call/presentation/screens/meeting_screen.dart';
import '../../data/model/schedule_model.dart';

class DateCard extends ConsumerWidget {
  final String date;
  // final String userName;
  // final String userId;
  final Schedule schedule;

  const DateCard(
      {super.key,
      required this.date,
      // required this.userName,
      // required this.userId,
      required this.schedule,
      re});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentNotifierProvider);
    final studentAuth = ref.watch(authViewModelProvider);
    ref.listen(paymentNotifierProvider, (prev, next) {
      if (next is PaymentFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            // backgroundColor: Colors.red,
          ),
        );
      }
      if (next is PaymentSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VideoCallPage(
              scheduleId: schedule.id,
              userName: studentAuth.user!.name,
              userId: studentAuth.user!.id,
            ),

            //     ChatScreen(
            //   userId: schedule.teacherId,
            //   userName: schedule.teacherName,
            //   chatWithName: schedule.studentName,
            //   scheduleId: schedule.id,
            // ),
          ),
        );
      }
    });

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left calendar icon
            const Icon(
              Icons.calendar_today,
              size: 36,
              color: CustomColor.primary,
            ),
            const SizedBox(width: 12),
            // Info column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: CustomColor.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            // Book button
            paymentState is PaymentLoading
                ? const CircularProgressIndicator()
                : TextButton(
                    // onPressed: () {
                    //   // Define your booking logic here
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text("Booking confirmed!")),
                    //   );
                    // },
                    onPressed: () {
                      final studentName =
                          ref.read(authViewModelProvider).user!.name;
                      final studentId =
                          ref.read(authViewModelProvider).user!.id;

                      ref
                          .read(paymentNotifierProvider.notifier)
                          .makePayment(schedule, studentName, studentId);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: CustomColor.primary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Book'),
                  ),
          ],
        ),
      ),
    );
  }
}
