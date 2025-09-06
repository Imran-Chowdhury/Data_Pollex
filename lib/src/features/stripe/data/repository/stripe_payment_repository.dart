import 'dart:convert';

import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// ✅ This should provide an http.Client, not StripeRepository
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// ✅ StripeRepository gets its client injected from above
final stripeRepositoryProvider = Provider<StripeRepository>((ref) {
  return StripeRepository(
    client: ref.read(httpClientProvider),
  );
});

class StripeRepository {
  final http.Client client;
  StripeRepository({required this.client});

  // StripeRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<DataResponse> createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    final body = {
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card',
    };

    final secretKey = dotenv.env['STRIPE_SECRET_KEY']!;
    final response = await client.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      return Failure('Failed to create PaymentIntent: ${response.body}');
      // throw Exception('Failed to create PaymentIntent: ${response.body}');
    }

    return Success(jsonDecode(response.body));
  }
}
