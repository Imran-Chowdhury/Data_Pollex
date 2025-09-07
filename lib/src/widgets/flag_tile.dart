import 'package:flutter/material.dart';

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
