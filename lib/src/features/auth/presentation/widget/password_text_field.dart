import 'package:data_pollex/src/core/utils/validator.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final Widget? prefixIcon;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: Validator.passwordValidator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: CustomColor.primary,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[700],
          ),
          onPressed: _toggleVisibility,
        ),
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

// class PasswordTextField extends StatefulWidget {
//   const PasswordTextField({
//     Key? key,
//     required this.labelText,
//     required this.controller,
//   }) : super(key: key);
//   final String labelText;
//   final TextEditingController controller;
//
//   @override
//   State<PasswordTextField> createState() => _PasswordTextFieldState();
// }
//
// class _PasswordTextFieldState extends State<PasswordTextField> {
//   // TextEditingController passwordController = TextEditingController();
//   bool _obscureText = true;
//
//   void _toggleVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: _obscureText,
//       controller: widget.controller,
//       decoration: InputDecoration(
//           fillColor: Colors.white,
//           filled: true,
//           labelText: widget.labelText,
//           border: const OutlineInputBorder(),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _obscureText ? Icons.visibility : Icons.visibility_off,
//             ),
//             onPressed: _toggleVisibility,
//           )),
//       validator: Validator.passwordValidator,
//     );
//   }
// }
