import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:data_pollex/src/features/stripe/data/repository/stripe_payment_repository.dart';
import 'package:data_pollex/src/features/student/teacher_date/data/model/schedule_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../student/teacher_date/data/repository/teacher_dates_repository_impl.dart';

final stripeUseCaseProvider = Provider((ref) {
  return StripeUseCase(
    teacherDatesRepository: ref.read(teachersDateRepoProvider),
    stripeRepository: ref.read(stripeRepositoryProvider),
  );
});

class StripeUseCase {
  StripeRepository stripeRepository;
  TeacherDatesRepository teacherDatesRepository;
  StripeUseCase(
      {required this.teacherDatesRepository, required this.stripeRepository});

  Future<DataResponse> makePayment(
      Schedule schedule, String studentName, String studentId) async {
    try {
      final paymentRes = await stripeRepository.createPaymentIntent(
        amount: '100', // amount in dollars, but convert to cents in repo
        currency: 'USD',
      );

      if (paymentRes is! Success) return paymentRes;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentRes.data['client_secret'],
          merchantDisplayName: 'Flutterwings',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      // ✅ Only book if payment went through
      final bookingRes = await teacherDatesRepository.bookSchedule(
          schedule, studentName, studentId);

      if (bookingRes is Success) {
        return Success(null); // everything good
      } else {
        // ⚠️ Payment succeeded but booking failed → optional refund here
        return Failure('Payment succeeded but booking failed');
      }
    } on StripeException catch (e) {
      return Failure(
          'Payment cancelled or failed: ${e.error.localizedMessage}');
    } catch (e) {
      return Failure('Unexpected error: $e');
    }
  }

// Future<DataResponse> makePayment(
  //     Schedule schedule, String studentName, String studentId) async {
  //   final paymentRes =
  //       stripeRepository.createPaymentIntent(amount: '100', currency: 'USD');
  //
  //   if (paymentRes is Success) {
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: paymentRes.data['client_secret'],
  //         merchantDisplayName: 'Flutterwings',
  //       ),
  //     );
  //
  //     await Stripe.instance.presentPaymentSheet();
  //     final bookingRes = await teacherDatesRepository.bookSchedule(
  //         schedule, studentName, studentId);
  //     if (bookingRes is Success) {
  //       return Success(null);
  //     } else if (bookingRes is Failure) {
  //       return bookingRes;
  //     } else {
  //       return Failure('Failed to book');
  //     }
  //   } else if (paymentRes is Failure) {
  //     return paymentRes;
  //   } else {
  //     return Failure('Failed to pay');
  //   }
  // }
}
