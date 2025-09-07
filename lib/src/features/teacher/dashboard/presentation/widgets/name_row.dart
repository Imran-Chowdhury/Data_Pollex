import 'package:data_pollex/src/features/auth/presentation/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/color.dart';
import '../../../../auth/presentation/providers/auth_providers.dart';

/// Name + Logout
class NameRow extends ConsumerWidget {
  const NameRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> signOut() async {
      await ref.read(authViewModelProvider.notifier).signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false,
      );
    }

    final authState = ref.watch(authViewModelProvider).user;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Greeting
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi,',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            Text(
              authState?.name ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Logout button
        InkWell(
          onTap: signOut,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.logout,
              color: CustomColor.primary,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
