import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';

class CalendarSetButton extends StatelessWidget {
  const CalendarSetButton({
    super.key,
    required this.title,
    required this.onClicked,
  });

  final void Function()? onClicked;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 4,
      ),
      onPressed: onClicked,
      child: Text(title),
    );
  }
}

// class CalendarSetButton extends StatelessWidget {
//   const CalendarSetButton({super.key, required this.selectedDate});
//
//   final DateTime selectedDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: CustomColor.primary,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         elevation: 4,
//       ),
//       onPressed: () {
//         Navigator.of(context).pop();
//         addBooking(context, selectedDate);
//       },
//       child: const Text('Set Date'),
//     );
//   }
//
//   void addBooking(BuildContext context, DateTime selectedDate) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AddBookingDialogWidget(selectedDate: selectedDate);
//       },
//     );
//   }
// }

class CalendarCancelButton extends StatelessWidget {
  const CalendarCancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 0,
      ),
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }
}
