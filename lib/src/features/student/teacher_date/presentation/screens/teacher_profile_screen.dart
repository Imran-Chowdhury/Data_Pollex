import 'package:data_pollex/src/core/base_state/payment_state.dart';
import 'package:data_pollex/src/features/student/teacher_date/data/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../../stripe/presentation/view_model/stripe_view_model.dart';
import '../../../../video_call/presentation/screens/chat_screen.dart';

class TeacherProfileScreen extends ConsumerWidget {
  final String teacherName;
  final Schedule schedule;

  const TeacherProfileScreen({
    super.key,
    required this.teacherName,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentNotifierProvider);

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
            builder: (context) => ChatScreen(
              userName: schedule.teacherName,
              chatWithName: schedule.studentName,
              scheduleId: schedule.id,
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(teacherName)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Teacher: $teacherName"),
            const SizedBox(height: 16),
            paymentState is PaymentLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final studentName =
                          ref.read(authViewModelProvider).user!.name;
                      final studentId =
                          ref.read(authViewModelProvider).user!.id;

                      ref
                          .read(paymentNotifierProvider.notifier)
                          .makePayment(schedule, studentName, studentId);
                    },
                    child: const Text("Confirm Booking"),
                  ),
          ],
        ),
      ),
    );
  }
}
