import 'package:data_pollex/src/core/constants/role.dart';
import 'package:data_pollex/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:data_pollex/src/features/student/dashboard/presentation/screens/student_dashboard_screen.dart';
import 'package:data_pollex/src/features/teacher/dashboard/presentation/screens/teacher_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/auth_button.dart';
import '../providers/auth_providers.dart';
import '../widget/header_container.dart';
import '../widget/signin_form.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authViewModelProvider.notifier).signIn(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
      // final user = ref.read(authViewModelProvider).user;
      //
      // /// If no error then navigate to appropriate screen
      // if (user != null) {
      //   if (user.role == Role.teacher) {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const TeacherDashboardScreen()),
      //     );
      //   } else {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const StudentDashboardScreen()),
      //     );
      //   }
      // }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.listenManual(authViewModelProvider, (prev, next) {
      /// Show toast on error
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error!),
        ));
      }

      /// If no error then navigate to appropriate screen
      if (next.user != null) {
        if (next.user!.role == Role.teacher) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const TeacherDashboardScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const StudentDashboardScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// Full width header
          const HeaderContainer(),

          /// Main body takes the available space
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SignInForm(
                      formKey: _formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Center(
                            child: AuthButton(
                              buttonName: 'Sign In',
                              buttonColor: const Color(0xFFed2f31),
                              icon: const Icon(
                                Icons.login_outlined,
                                color: Colors.white,
                              ),
                              onpressed: signIn,
                            ),
                          ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            emailController.clear();
                            passwordController.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign up!",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
