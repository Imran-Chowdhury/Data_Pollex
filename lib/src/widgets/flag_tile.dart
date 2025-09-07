import 'package:flutter/material.dart';

// class FlagTile extends StatelessWidget {
//   final String countryName;
//   final String flagAssetPath;
//   final double width;
//   final double height;
//
//   const FlagTile({
//     Key? key,
//     required this.countryName,
//     required this.flagAssetPath,
//     this.width = 200,
//     this.height = 180,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Material(
//         elevation: 6, // gives elevation/shadow
//         borderRadius: BorderRadius.circular(24), // rounded corners
//         clipBehavior: Clip.antiAlias, // ensures child is clipped
//         child: Container(
//           width: width,
//           height: height,
//           color: Colors.black12, // optional background
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Flag image as background
//               Image.asset(
//                 flagAssetPath,
//                 fit: BoxFit.cover,
//               ),
//               // Country name at bottom-right
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     countryName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                       shadows: [
//                         Shadow(
//                           color: Colors.black54,
//                           offset: Offset(1, 1),
//                           blurRadius: 3,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FlagTile extends StatelessWidget {
//   final String countryName;
//   final String flagAssetPath;
//   final double width;
//   final double height;
//
//   const FlagTile({
//     Key? key,
//     required this.countryName,
//     required this.flagAssetPath,
//     this.width = 150, // Reduced width for a sleeker look
//     this.height = 120, // Reduced height for a sleeker look
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: 16.0), // Adjusted padding for a more compact layout
//       child: Material(
//         elevation: 8, // Added a more prominent shadow for a premium look
//         borderRadius:
//             BorderRadius.circular(16), // Slightly rounded corners for elegance
//         clipBehavior: Clip.antiAlias,
//         child: Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2), // Soft shadow
//                 spreadRadius: 1,
//                 blurRadius: 6,
//                 offset: Offset(0, 4), // Slightly offset shadow for more depth
//               ),
//             ],
//           ),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Flag image as background with a subtle overlay effect
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(
//                     16), // Ensuring the image matches the rounded corners
//                 child: Image.asset(
//                   flagAssetPath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               // Country name at bottom-right with better positioning and a soft shadow
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(
//                       12.0), // Adjusted padding for better alignment
//                   child: Text(
//                     countryName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18, // Slightly smaller text for a refined look
//                       shadows: [
//                         Shadow(
//                           color: Colors.black54,
//                           offset: Offset(1, 1),
//                           blurRadius: 3,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class FlagTile extends StatelessWidget {
  final String countryName;
  final String flagAssetPath;
  final double size; // Single size property for both width and height

  const FlagTile({
    Key? key,
    required this.countryName,
    required this.flagAssetPath,
    this.size = 150, // Default size for square tile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted padding
      child: Material(
        elevation: 8, // Shadow elevation for premium look
        borderRadius: BorderRadius.circular(16), // Rounded corners
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: size,
          height: size, // Equal width and height to make it square
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Soft shadow
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 4), // Slight shadow offset
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Flag image as background with correct aspect ratio
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  flagAssetPath,
                  fit: BoxFit.cover, // Cover the square area without distortion
                ),
              ),
              // Country name at bottom-right with proper padding
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    countryName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
