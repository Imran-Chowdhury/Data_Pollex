import 'package:data_pollex/src/core/constants/role.dart';
import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/auth_button.dart';
import '../widget/header_container.dart';
import '../widget/signup_form.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<String> _roleNotifier = ValueNotifier(Role.teacher);

  // void signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     await ref.read(authViewModelProvider.notifier).signUp(
  //           nameController.text.trim(),
  //           emailController.text.trim(),
  //           passwordController.text.trim(),
  //           confirmPasswordController.text.trim(),
  //           _roleNotifier.value,
  //         );
  //   }
  //   final String? error = ref.read(authViewModelProvider).error;
  //   if (error == null) {
  //     Navigator.pop(context);
  //   }
  // }
  void signUp() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with the sign-up
      await ref.read(authViewModelProvider.notifier).signUp(
            nameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim(),
            confirmPasswordController.text.trim(),
            _roleNotifier.value,
          );

      final error = ref.read(authViewModelProvider).error;
      if (error == null) {
        // If there's no error, navigate back to the SignInScreen
        Navigator.pop(context);
      } else {
        // Handle error (show snack bar or alert) if sign-up fails
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   ref.listenManual(authViewModelProvider, (prev, next) {
  //     if (next.error != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(next.error!),
  //       ));
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider).isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Column(
        children: [
          const HeaderContainer(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Form
                      SignUpForm(
                        formKey: _formKey,
                        nameController: nameController,
                        // height: height,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        roleNotifier: _roleNotifier,
                      ),

                      Center(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : AuthButton(
                                buttonName: 'Sign Up',
                                // buttonColor: const Color(0XFFd71e23),
                                icon: const Icon(
                                  Icons.app_registration_sharp,
                                  color: Colors.white,
                                ),
                                onpressed: signUp,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
