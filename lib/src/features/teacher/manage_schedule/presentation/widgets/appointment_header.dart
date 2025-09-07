import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/color.dart';

class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: const BoxDecoration(
        color: CustomColor.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Text(
        'Appointments: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
        style: const TextStyle(
          color: CustomColor.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
