import 'package:data_pollex/src/features/stripe/domain/use_case/stripe_booking_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base_state/payment_state.dart';
import '../../../../core/base_state/remote_response.dart';
import '../../../student/teacher_date/data/model/schedule_model.dart';

final paymentNotifierProvider =
    NotifierProvider<PaymentNotifier, PaymentState>(PaymentNotifier.new);

class PaymentNotifier extends Notifier<PaymentState> {
  late final StripeUseCase _useCase;

  @override
  PaymentState build() {
    _useCase = ref.read(stripeUseCaseProvider);
    return const PaymentInitial();
  }

  Future<void> makePayment(
      Schedule schedule, String studentName, String studentId) async {
    state = const PaymentLoading();

    final res = await _useCase.makePayment(schedule, studentName, studentId);

    if (res is Success) {
      state = const PaymentSuccess();
    } else if (res is Failure) {
      state = PaymentFailure(res.message);
    } else {
      state = const PaymentFailure('Unknown error');
    }
  }
}
