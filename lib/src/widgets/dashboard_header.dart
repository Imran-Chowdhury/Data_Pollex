import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/name_row.dart';
import 'package:flutter/material.dart';

import '../core/utils/color.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double height = size.height;

    return Container(
      width: double.infinity,
      height: height > 600 ? 220 : 170,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColor.primary,
            CustomColor.primaryDark, // darker tone of primary
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: NameRow(),
        ),
      ),
    );
  }
}
