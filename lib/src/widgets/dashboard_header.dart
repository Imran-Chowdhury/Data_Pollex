import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/name_row.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    // required this.height,
  });

  // final double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double height = size.height;

    return Container(
      width: double.infinity,
      height: height > 600 ? 200 : 150,
      decoration: const BoxDecoration(
        color: Color(0xFFed2f31), // branded red
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(80),
          bottomLeft: Radius.circular(80),
        ),
      ),
      child: const Center(
        child: NameRow(),
      ),
    );
  }
}
