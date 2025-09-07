import 'package:data_pollex/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import '../../../../../widgets/background_container.dart';
import '../widget/date_list.dart';

class TeacherBookedLessonScreen extends StatelessWidget {
  final String language;

  const TeacherBookedLessonScreen({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        title: const Text(
          'Booked Schedules',
          style: TextStyle(
            color: CustomColor.white,
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: DateList(
            language: language,
          ),
        ),
      ),
    );
  }
}
