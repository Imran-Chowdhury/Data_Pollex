// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:data_pollex/src/features/teacher/dashboard/presentation/widgets/dashboard_tile.dart';
// import 'package:flutter/material.dart';
//
// class HorizontalProjectSlider extends StatelessWidget {
//   const HorizontalProjectSlider({super.key, required this.width});
//   final double width;
//   final List<TeacherDashboardTile> tiles = const [
//     TeacherDashboardTile(
//       icon: Icons.menu_book,
//       title: "Manage Lessons",
//       color: Colors.deepPurpleAccent,
//     ),
//     TeacherDashboardTile(
//       icon: Icons.schedule,
//       title: "Schedule",
//       color: Colors.purple,
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     if (tiles.isEmpty) {
//       return const Center(
//         child: Text(
//           'Opp! No projects found. Start by adding a project',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 16.0,
//           ),
//         ),
//       );
//     }
//
//     return CarouselSlider.builder(
//       itemCount: tiles.length,
//       itemBuilder: (BuildContext context, int index, int realIndex) {
//         final project = tiles[index];
//
//         return project;
//       },
//       options: CarouselOptions(
//         height: 200,
//         enlargeCenterPage: true,
//         viewportFraction: 0.6,
//         initialPage: 0,
//         enableInfiniteScroll: false,
//         autoPlay: false,
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }
