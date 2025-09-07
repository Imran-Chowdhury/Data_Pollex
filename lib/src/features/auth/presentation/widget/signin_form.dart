import 'package:data_pollex/src/features/auth/presentation/widget/password_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/validator.dart';
import 'custom_text_field.dart';

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
            prefixIcon: const Icon(
              Icons.email,
            ),
          ),
          const SizedBox(height: 24),
          PasswordTextField(
            labelText: 'Password',
            controller: passwordController,
            prefixIcon: const Icon(
              Icons.password,
            ),
          ),
        ],
      ),
    );
  }
}
