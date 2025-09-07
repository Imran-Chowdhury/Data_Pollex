import 'package:data_pollex/src/features/student/dashboard/presentation/screens/language_option_screen.dart';
import 'package:data_pollex/src/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    return Scaffold(
      // backgroundColor: CustomColor.background,
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardHeader(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16, right: 16),
            //   child: Consumer(
            //     builder: (BuildContext context, WidgetRef ref, Widget? child) {
            //       return Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           // const Text(
            //           //   "Having fun learning?",
            //           //   style: TextStyle(
            //           //       fontSize: 28, fontWeight: FontWeight.bold),
            //           // ),
            //           IconButton(
            //             icon: const Icon(Icons.logout),
            //             onPressed: () {
            //               ref
            //                   .read(authViewModelProvider.notifier)
            //                   .signOut()
            //                   .then((_) {
            //                 Navigator.pushReplacement(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => const SignInScreen(),
            //                   ),
            //                 );
            //               });
            //             },
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(height: 16),

            // Cards grid
            LayoutBuilder(builder: (context, constraints) {
              final crossAxisCount = isLargeScreen ? 3 : 2;
              return GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                children: [
                  GestureDetector(
                    child: const DashboardCard(
                      title: "Booked Lessons",
                      icon: Icons.book_online,
                      color: CustomColor.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LanguageOptionScreen(
                            whereTo: 'Booked Lessons',
                          ),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageOptionScreen(
                            whereTo: 'Teacher Availability',
                          ),
                        ),
                      );
                    },
                    child: const DashboardCard(
                      title: "Availability",
                      icon: Icons.access_time,
                      color: CustomColor.greenAccent,
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),

            // Upcoming Schedules Section
            const Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: const Text(
                "Upcoming Schedules",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Schedules
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: List.generate(
                  6,
                  (index) => Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: CustomColor.primary,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Student ${index + 1} booked a lesson"),
                      subtitle:
                          const Text("Scheduled for tomorrow at 10:00 AM"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Dashboard Card
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // color: color,
      color: CustomColor.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: CustomColor.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    color: CustomColor.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class StudentDashboardScreen extends StatelessWidget {
//   const StudentDashboardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isLargeScreen = size.width > 600;
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Teacher Dashboard"),
//       //   backgroundColor: Colors.deepPurple,
//       //   elevation: 0,
//       // ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const DashboardHeader(),
//             Consumer(
//               builder: (BuildContext context, WidgetRef ref, Widget? child) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Welcome Back!",
//                       style:
//                           TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.logout),
//                       onPressed: () {
//                         ref
//                             .read(authViewModelProvider.notifier)
//                             .signOut()
//                             .then((_) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const SignInScreen(),
//                             ),
//                           );
//                         });
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//
//             // Cards grid
//             LayoutBuilder(builder: (context, constraints) {
//               final crossAxisCount = isLargeScreen ? 3 : 1;
//               return GridView(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: crossAxisCount,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 1.2,
//                 ),
//                 children: [
//                   GestureDetector(
//                     child: const DashboardCard(
//                       title: "Booked Lessons",
//                       icon: Icons.book_online,
//                       color: Colors.orangeAccent,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const LanguageOptionScreen(
//                             whereTo: 'Booked Lessons',
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   // DashboardCard(
//                   //   title: "Upcoming Schedules",
//                   //   icon: Icons.schedule,
//                   //   color: Colors.lightBlueAccent,
//                   // ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LanguageOptionScreen(
//                             whereTo: 'Teacher Availability',
//                           ),
//                         ),
//                       );
//                     },
//                     child: const DashboardCard(
//                       title: "Availability",
//                       icon: Icons.access_time,
//                       color: Colors.greenAccent,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//
//             const SizedBox(height: 24),
//
//             // Optional: Quick stats or details section
//             const Text(
//               "Upcoming Schedules",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//
//             Column(
//               children: List.generate(
//                 3,
//                 (index) => Card(
//                   elevation: 3,
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Colors.deepPurple,
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                     ),
//                     title: Text("Student ${index + 1} booked a lesson"),
//                     subtitle: const Text("Scheduled for tomorrow at 10:00 AM"),
//                     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color color;
//
//   const DashboardCard({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             colors: [color.withOpacity(0.7), color],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 48, color: Colors.white),
//             const SizedBox(height: 16),
//             Text(
//               title,
//               style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
