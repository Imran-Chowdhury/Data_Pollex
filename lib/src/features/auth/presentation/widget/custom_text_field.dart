import 'package:flutter/material.dart';

import '../../../../core/utils/color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validate;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final Widget? obscureIcon; // Optional obscure icon
  final Widget? prefixIcon; // Optional prefix icon

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validate,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.obscureIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: CustomColor.primary,
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: obscureIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CustomColor.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final String? Function(String?)? validate;
//   final VoidCallback? onTap;
//   final bool readOnly;
//   final bool obscureText;
//   final Widget? obscureIcon; // Optional obscure icon
//
//   CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.labelText,
//     required this.validate,
//     this.onTap,
//     this.readOnly = false,
//     this.obscureText = false,
//     this.obscureIcon, // Optional obscure icon parameter
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: obscureText,
//       controller: controller,
//       decoration: InputDecoration(
//         fillColor: Colors.white,
//         filled: true,
//         labelText: labelText,
//         border: const OutlineInputBorder(),
//         suffixIcon: obscureIcon, // Show obscure icon if provided
//       ),
//       validator: validate,
//       onTap: onTap,
//       readOnly: readOnly,
//     );
//   }
// }
