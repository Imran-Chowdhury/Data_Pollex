import 'package:data_pollex/src/features/auth/presentation/widget/password_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/role.dart';
import '../../../../core/utils/color.dart';
import '../../../../core/utils/validator.dart';
import 'custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required ValueNotifier<String> roleNotifier,
  })  : _formKey = formKey,
        _roleNotifier = roleNotifier;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueNotifier<String> _roleNotifier;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomTextField(
            controller: nameController,
            labelText: 'Name',
            validate: Validator.personNameValidator,
            prefixIcon: const Icon(
              Icons.person,
              color: CustomColor.primary,
            ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: emailController,
            labelText: 'Email',
            validate: Validator.emailValidator,
            prefixIcon: const Icon(
              Icons.email,
              color: CustomColor.primary,
            ),
          ),
          const SizedBox(height: 24),

          PasswordTextField(
            labelText: 'Password',
            controller: passwordController,
            prefixIcon: const Icon(
              Icons.password,
              color: CustomColor.primary,
            ),
          ),
          const SizedBox(height: 24),

          PasswordTextField(
            labelText: 'Confirm Password',
            controller: confirmPasswordController,
            prefixIcon: const Icon(
              Icons.password_outlined,
              color: CustomColor.primary,
            ),
          ),

          /// Role selection
          ValueListenableBuilder<String>(
            valueListenable: _roleNotifier,
            builder: (context, role, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: CustomColor.primary,
                    value: role == Role.teacher,
                    onChanged: (_) => _roleNotifier.value = Role.teacher,
                  ),
                  const Text('Teacher'),
                  Checkbox(
                    activeColor: CustomColor.primary,
                    value: role == Role.student,
                    onChanged: (_) => _roleNotifier.value = Role.student,
                  ),
                  const Text('Student'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
