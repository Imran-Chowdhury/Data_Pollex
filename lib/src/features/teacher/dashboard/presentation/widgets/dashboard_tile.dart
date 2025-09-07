import 'package:data_pollex/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CustomColor.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: CustomColor.primary,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LessonCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//
//   const LessonCard({super.key, required this.title, required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 20.0),
//           child: Container(
//             width: 300,
//             height: 150,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: CustomColor.primaryColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(.1),
//                   blurRadius: 12,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Row(
//                 children: [
//                   Icon(
//                     icon,
//                     size: 50,
//                     color: CustomColor.white,
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
