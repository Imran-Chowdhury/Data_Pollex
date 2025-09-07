import 'package:flutter/material.dart';

class FlagTile extends StatelessWidget {
  final String countryName;
  final String flagAssetPath;
  final double width;
  final double height;

  const FlagTile({
    Key? key,
    required this.countryName,
    required this.flagAssetPath,
    this.width = 200,
    this.height = 180,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Material(
        elevation: 6, // gives elevation/shadow
        borderRadius: BorderRadius.circular(24), // rounded corners
        clipBehavior: Clip.antiAlias, // ensures child is clipped
        child: Container(
          width: width,
          height: height,
          color: Colors.black12, // optional background
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Flag image as background
              Image.asset(
                flagAssetPath,
                fit: BoxFit.cover,
              ),
              // Country name at bottom-right
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    countryName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
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
//     this.width = 300,
//     this.height = 200,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: width,
//         height: height,
//         margin: const EdgeInsets.symmetric(vertical: 12), // spacing
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           image: DecorationImage(
//             image: AssetImage(flagAssetPath),
//             // fit: BoxFit.cover,
//             fit: BoxFit.contain,
//           ),
//         ),
//         child: Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               countryName,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25,
//                 shadows: [
//                   Shadow(
//                     color: Colors.black54,
//                     offset: Offset(1, 1),
//                     blurRadius: 3,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
