import 'package:data_pollex/src/core/utils/color.dart';
import 'package:flutter/cupertino.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: CustomColor.white, // background color of the list container
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: child);
  }
}

// class BackgroundContainer extends StatelessWidget {
//   const BackgroundContainer({super.key, required this.child});
//
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/img_1.png'),
//           // AssetImage('assets/background.png'), // Add your image path here
//           fit: BoxFit.cover, // Ensures the image covers the entire container
//         ),
//         color: CustomColor
//             .white, // Background color for the container in case image doesn't load
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(32),
//           topRight: Radius.circular(32),
//         ),
//       ),
//       child: child,
//     );
//   }
// }
