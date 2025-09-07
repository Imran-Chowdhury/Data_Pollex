import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../../../../../widgets/background_container.dart';
import '../widgets/upcoming_schedule_list.dart';

class UpcomingSchedulesScreen extends StatelessWidget {
  const UpcomingSchedulesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        title: const Text(
          'Upcoming Schedules',
          style: TextStyle(
            color: CustomColor.white,
          ),
        ),
      ),
      body: const BackgroundContainer(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: UpcomingScheduleList(),
        ),
      ),
    );
  }
}
