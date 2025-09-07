import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonName,
    required this.onpressed,
    required this.icon,
    required this.buttonColor,
  });

  final String buttonName;
  final Color buttonColor;
  final Icon icon;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // nice button height (smaller than before)
      width: 180, // full width of parent
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3, // subtle shadow
        ),
        onPressed: onpressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              buttonName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18, // smaller, cleaner text
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
