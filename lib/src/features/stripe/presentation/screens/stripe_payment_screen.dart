import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: const Text('Make Card Payment'),
              onPressed: () async {
                await makeCardPayment();
              },
            ),
          ),
          // Center(
          //   child: ElevatedButton(
          //     child: const Text('Google Pay'),
          //     onPressed: () async {
          //       await makeGooglePay();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> makeCardPayment() async {
    try {
      // Create payment intent data
      paymentIntent = await createPaymentIntent('1000', 'INR');
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          // googlePay: const PaymentSheetGooglePay(
          //   // Currency and country code is accourding to India
          //   testEnv: true,
          //   // currencyCode: "INR",
          //   // merchantCountryCode: "IN",
          //   currencyCode: "USD",
          //   merchantCountryCode: "US",
          // ),
          // Merchant Name
          merchantDisplayName: 'Flutterwings',
          // return URl if you want to add
          // returnURL: 'flutterstripe://redirect',
        ),
      );
      // Display payment sheet
      displayPaymentSheet();
    } catch (e) {
      print("exception $e");

      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  // Future<void> makeGooglePay() async {
  //   final googlePaySupported = await Stripe.instance.isPlatformPaySupported(
  //     googlePay: IsGooglePaySupportedParams(testEnv: true),
  //   );
  //   if (googlePaySupported) {
  //     try {
  //       // 1. fetch Intent Client Secret from backend
  //       final response = await createPaymentIntent('10', 'USD');
  //       final clientSecret = response['client_secret'];
  //       // 2.present google pay sheet
  //       await Stripe.instance.confirmPlatformPayPaymentIntent(
  //         clientSecret: clientSecret,
  //         confirmParams: const PlatformPayConfirmParams.googlePay(
  //           googlePay: GooglePayParams(
  //             testEnv: true,
  //             merchantName: 'Example Merchant Name',
  //             merchantCountryCode: 'Es',
  //             currencyCode: 'EUR',
  //           ),
  //         ),
  //         // PresentGooglePayParams(clientSecret: clientSecret),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Google Pay payment successfully completed'),
  //         ),
  //       );
  //     } catch (e) {
  //       if (e is StripeException) {
  //         log(
  //           'Error during google pay',
  //           error: e.error,
  //           stackTrace: StackTrace.current,
  //         );
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text('Error: ${e.error}')));
  //       } else {
  //         log(
  //           'Error during google pay',
  //           error: e,
  //           stackTrace: (e as Error?)?.stackTrace,
  //         );
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text('Error: $e')));
  //       }
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //      const SnackBar(content: Text('Google pay is not supported on this device')),
  //     );
  //   }
  // }

  displayPaymentSheet() async {
    try {
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
      // Displaying snackbar for it
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Paid successfully")));
      paymentIntent = null;
    } on StripeException catch (e) {
      // If any error comes during payment
      // so payment will be cancelled
      print('Error: $e');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(" Payment Cancelled")));
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var secretKey = dotenv.env['STRIPE_SECRET_KEY']!;
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      print('Payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('Error charging user: ${err.toString()}');
    }
  }
}
