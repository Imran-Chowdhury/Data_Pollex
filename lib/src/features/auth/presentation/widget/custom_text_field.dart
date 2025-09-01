import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validate;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final Widget? obscureIcon; // Optional obscure icon

  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validate,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.obscureIcon, // Optional obscure icon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: obscureIcon, // Show obscure icon if provided
      ),
      validator: validate,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
