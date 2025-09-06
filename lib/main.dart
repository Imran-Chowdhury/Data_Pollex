import 'package:data_pollex/src/core/constants/role.dart';
import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:data_pollex/src/features/auth/presentation/screens/signin_screen.dart';
import 'package:data_pollex/src/features/student/dashboard/presentation/screens/student_dashboard_screen.dart';
import 'package:data_pollex/src/features/teacher/dashboard/presentation/screens/teacher_dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensures binding for Firebase
  await Firebase.initializeApp(); // initialize Firebase
  await dotenv.load(fileName: ".env"); // load env file
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    if (authState.isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    if (authState.user != null) {
      // Auto navigate to correct dashboard
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: authState.user!.role == Role.teacher
            ? const TeacherDashboardScreen()
            : const StudentDashboardScreen(),
      );
    } else {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      );
    }
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // ensures binding for Firebase
//   await Firebase.initializeApp(); // initialize Firebase
//   await dotenv.load(fileName: ".env");
//   Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
//   runApp(const MyApp());
// }

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ProviderScope(
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const SignInScreen();
//     // return const CalendarScreen();
//     // return const TeacherDashboardScreen();
//   }
// }
