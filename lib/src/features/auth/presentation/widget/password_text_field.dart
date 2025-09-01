import 'package:data_pollex/src/core/utils/validator.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);
  final String labelText;
  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  // TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _toggleVisibility,
          )),
      validator: Validator.passwordValidator,
    );
  }
}

// class CustomTextField extends StatefulWidget {
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
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: widget.obscureText,
//       controller: widget.controller,
//       decoration: InputDecoration(
//         fillColor: Colors.white,
//         filled: true,
//         labelText: widget.labelText,
//         border: const OutlineInputBorder(),
//         suffixIcon: widget.obscureIcon, // Show obscure icon if provided
//       ),
//       validator: widget.validate,
//       onTap: widget.onTap,
//       readOnly: widget.readOnly,
//     );
//   }
// }
