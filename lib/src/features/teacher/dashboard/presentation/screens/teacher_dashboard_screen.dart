import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/dashboard_tile.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/presentation/screens/manage_lesson_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/dashboard_header.dart';
import '../../../manage_schedule/presentation/screens/calendar_screen.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header stays on top
          const Align(
            alignment: Alignment.topCenter,
            child: DashboardHeader(),
          ),

          // Expand remaining space for centering tiles
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageLessonsScreen(),
                        ),
                      );
                    },
                    child: const TeacherDashboardTile(
                      icon: Icons.menu_book,
                      title: "Manage Lessons",
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  const SizedBox(width: 16), // spacing between tiles
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarScreen(),
                        ),
                      );
                    },
                    child: const TeacherDashboardTile(
                      icon: Icons.schedule,
                      title: "Schedule",
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
