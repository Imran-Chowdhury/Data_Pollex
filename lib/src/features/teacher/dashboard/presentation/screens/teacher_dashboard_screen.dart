import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../../../../../widgets/dashboard_header.dart';

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
          const DashboardHeader(),
          const SizedBox(height: 20),

          // Welcome message
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'What will you teach today?',
                    style: TextStyle(
                      fontSize: 26,
                      color:
                          CustomColor.primary, // contrast with white background
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Lesson tiles
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LessonCard(
                    title: 'Manage Lessons',
                    icon: Icons.menu_book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageLessonsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  LessonCard(
                    title: 'Schedules',
                    icon: Icons.schedule,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarScreen(),
                        ),
                      );
                    },
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

// class TeacherDashboardScreen extends StatelessWidget {
//   const TeacherDashboardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Column(
//         children: [
//           // Header stays on top
//           const Align(
//             alignment: Alignment.topCenter,
//             child: DashboardHeader(),
//           ),
//           // const NameRow(),
//
//           const Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'What will you teach today?',
//                     style: TextStyle(
//                       // letterSpacing: 1,
//                       fontSize: 30,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Expand remaining space for centering tiles
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ManageLessonsScreen(),
//                         ),
//                       );
//                     },
//                     child: const LessonCard(
//                       title: 'Manage Lessons',
//                       icon: Icons.menu_book,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CalendarScreen(),
//                         ),
//                       );
//                     },
//                     child: const LessonCard(
//                       title: 'Schedules',
//                       icon: Icons.schedule,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
