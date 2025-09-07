import 'dart:developer';

import 'package:data_pollex/src/features/student/teacher_date/presentation/widget/date_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/color.dart';
import '../../data/model/schedule_model.dart';
import '../view_model/dates_view_model.dart';

class TeacherDatesList extends ConsumerWidget {
  final String teacherId;
  final String language;

  const TeacherDatesList({
    super.key,
    required this.teacherId,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ScheduleFilter(teacherId: teacherId, language: language);
    final schedulesAsync = ref.watch(
      schedulesStreamProvider(
        filter,
      ),
    );

    return schedulesAsync.when(
      data: (schedules) {
        log('The schedules are $schedules');
        if (schedules.isEmpty) {
          return const Center(
              child: Text(
            "No schedules available",
            style: TextStyle(color: CustomColor.primary, fontSize: 20),
          ));
        }
        return ListView.builder(
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final schedule = schedules[index];

            return DateCard(
              date: schedule.date,
              // userName: schedule.studentName,
              schedule: schedule,
              // userId: schedule.studentId,
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, _) => Center(
        child: Text("Error: $err"),
      ),
    );
  }
}
