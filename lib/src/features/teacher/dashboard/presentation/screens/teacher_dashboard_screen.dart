import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/dashboard_tile.dart';
import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/name_row.dart';
import 'package:flutter/material.dart';

import '../../../manage_lesson/presentation/screens/manage_lesson_screen.dart';
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
          // const Align(
          //   alignment: Alignment.topCenter,
          //   child: DashboardHeader(),
          // ),
          const NameRow(),

          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'What will you teach today?',
                    style: TextStyle(
                      // letterSpacing: 1,
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),

          // Expand remaining space for centering tiles
          Expanded(
            child: Center(
              child: Column(
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
                    child: const LessonCard(
                      title: 'Manage Lessons',
                      icon: Icons.menu_book,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarScreen(),
                        ),
                      );
                    },
                    child: const LessonCard(
                      title: 'Schedules',
                      icon: Icons.schedule,
                    ),
                  ),

                  /// OG
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const ManageLessonsScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: const TeacherDashboardTile(
                  //     icon: Icons.menu_book,
                  //     title: "Manage Lessons",
                  //     color: Colors.deepPurpleAccent,
                  //   ),
                  // ),
                  // const SizedBox(width: 16), // spacing between tiles
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const CalendarScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: const TeacherDashboardTile(
                  //     icon: Icons.schedule,
                  //     title: "Schedule",
                  //     color: Colors.purple,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
