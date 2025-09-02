import 'package:data_pollex/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validator.dart';
import '../../../../widgets/custom_button.dart';
import '../providers/auth_providers.dart';
import '../widget/custom_text_field.dart';
import '../widget/header_container.dart';
import '../widget/password_text_field.dart';

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
      await ref
          .read(authViewModelProvider.notifier)
          .signIn(emailController.text.trim(), passwordController.text.trim());
    }
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
                    SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Center(
                            child: CustomButton(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
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

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SIGN IN',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomTextField(
            controller: emailController,
            labelText: 'Email',
            validate: Validator.emailValidator,
          ),
          const SizedBox(height: 24),
          PasswordTextField(
            labelText: 'Password',
            controller: passwordController,
          ),
        ],
      ),
    );
  }
}
