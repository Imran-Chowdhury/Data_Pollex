import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/dashboard_tile.dart';
import 'package:data_pollex/src/features/teacher/manage_lesson/presentation/screens/manage_lesson_screen.dart';
import 'package:data_pollex/src/features/teacher/manage_schedule/presentation/screens/calendar_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/dashboard_header.dart';

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
                              builder: (context) =>
                                  const ManageLessonsScreen()));
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
                              builder: (context) => const CalendarScreen()));
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

// class TeacherDashboardScreen extends StatelessWidget {
//   const TeacherDashboardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     double width = size.width;
//     double height = size.height;
//     log('The width is $width');
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: FooterContainer(
//               height: height,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // const NameRow(),
//                 const SizedBox(height: 40),
//                 // Center the slider using Expanded + Center
//                 width < 600
//                     ? Expanded(
//                         child: Center(
//                           child: HorizontalProjectSlider(width: width),
//                         ),
//                       )
//                     : Center(
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.center, // Center horizontally
//                           crossAxisAlignment:
//                               CrossAxisAlignment.center, // Center vertically
//                           children: [
//                             TeacherDashboardTile(
//                               icon: Icons.menu_book,
//                               title: "Manage Lessons",
//                               color: Colors.deepPurpleAccent,
//                             ),
//                             const SizedBox(
//                                 width: 20), // Add spacing between tiles
//                             TeacherDashboardTile(
//                               icon: Icons.schedule,
//                               title: "Schedule",
//                               color: Colors.purple,
//                             ),
//                           ],
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
