import 'package:data_pollex/src/features/auth/presentation/widget/password_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/role.dart';
import '../../../../core/utils/validator.dart';
import 'custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.height,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required ValueNotifier<String> roleNotifier,
  })  : _formKey = formKey,
        _roleNotifier = roleNotifier;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final double height;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueNotifier<String> _roleNotifier;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: nameController,
            labelText: 'Name',
            validate: Validator.personNameValidator,
          ),
          SizedBox(height: height * 0.03),
          CustomTextField(
            controller: emailController,
            labelText: 'Email',
            validate: Validator.emailValidator,
          ),
          SizedBox(height: height * 0.03),
          // CustomTextField(
          //   controller: passwordController,
          //   labelText: 'Password',
          //   obscureText: visibleState,
          //   validate: Validator.passwordValidator,
          //   obscureIcon: IconButton(
          //     icon: Icon(visibleState
          //         ? Icons.visibility_off
          //         : Icons.visibility),
          //     onPressed: () {
          //       // Toggle visibility state here
          //       ref
          //           .watch(obscureControllerProvider.notifier)
          //           .changeVisibility();
          //     },
          //   ),
          // ),

          PasswordTextField(
            labelText: 'Password',
            controller: passwordController,
          ),
          SizedBox(height: height * 0.03),
          // CustomTextField(
          //   controller: confirmPasswordController,
          //   labelText: 'Confirm Password',
          //   obscureText: confirmVisibleState,
          //   validate: Validator.confirmPasswordValidator,
          //   obscureIcon: IconButton(
          //     icon: Icon(confirmVisibleState
          //         ? Icons.visibility_off
          //         : Icons.visibility),
          //     onPressed: () {
          //       // Toggle visibility state here
          //       ref
          //           .watch(confirmPasswordVisibilityProvider
          //               .notifier)
          //           .changeVisibility();
          //     },
          //   ),
          // ),

          PasswordTextField(
            labelText: 'Confirm Password',
            controller: confirmPasswordController,
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Checkbox(
          //       activeColor: const Color(0xFFed2f31),
          //       value: _isTeacher,
          //       onChanged: (_) => _toggleRole('admin'),
          //     ),
          //     const Text('Admin'),
          //     Checkbox(
          //       activeColor: const Color(0xFFed2f31),
          //       value: _isStudent,
          //       onChanged: (_) => _toggleRole('mechanic'),
          //     ),
          //     const Text('Mechanic'),
          //   ],
          // ),

          // Role selection
          ValueListenableBuilder<String>(
            valueListenable: _roleNotifier,
            builder: (context, role, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: const Color(0xFFed2f31),
                    value: role == Role.teacher,
                    onChanged: (_) => _roleNotifier.value = Role.teacher,
                  ),
                  const Text('Teacher'),
                  Checkbox(
                    activeColor: const Color(0xFFed2f31),
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
