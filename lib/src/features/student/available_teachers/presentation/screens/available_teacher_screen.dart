import 'package:data_pollex/src/widgets/background_container.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../widget/teacher_list.dart';

class TeacherAvailabilityScreen extends StatelessWidget {
  const TeacherAvailabilityScreen({super.key, required this.language});
  final String language;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        title: Text(
          '$language Teachers',
          style: const TextStyle(
            color: CustomColor.white,
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TeacherList(
            language: language,
          ),
        ),
      ),
    );
  }
}
