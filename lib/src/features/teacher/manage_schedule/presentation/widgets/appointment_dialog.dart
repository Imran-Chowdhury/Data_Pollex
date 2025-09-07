import 'package:data_pollex/src/features/teacher/manage_schedule/presentation/view_model/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_booking_dialog.dart';
import 'calendar_button.dart';
import 'appointment_header.dart';
import 'appointment_list.dart';

class AppointmentDialogWidget extends ConsumerWidget {
  const AppointmentDialogWidget({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsForDate = ref
        .read(scheduleControllerProvider)
        .value!
        .where((a) =>
            a.startTime.year == selectedDate.year &&
            a.startTime.month == selectedDate.month &&
            a.startTime.day == selectedDate.day)
        .toList();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 12,
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          children: [
            // Header
            AppointmentHeader(selectedDate: selectedDate),

            // Body
            Expanded(
              child: appointmentsForDate.isEmpty
                  ? const Center(
                      child: Text(
                        'No bookings',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : AppointmentList(appointmentsForDate: appointmentsForDate),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CalendarCancelButton(),
                  const SizedBox(width: 12),
                  CalendarSetButton(
                    selectedDate: selectedDate,
                    onClicked: () {
                      addBooking(context, selectedDate);
                    },
                    title: 'Set Date',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addBooking(BuildContext context, DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (context) {
        return AddBookingDialogWidget(selectedDate: selectedDate);
      },
    );
  }
}
