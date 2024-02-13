import 'package:flutter/material.dart';
import 'package:voice_hub/core/colors.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final String textOverlay;

  const ImageContainer({
    Key? key,
    required this.imageUrl,
    this.height = 150,
    this.width = 180,
    this.textOverlay = 'Hello Writer',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
      child: Stack(
        children: [
          // Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0),
                  BlendMode.srcOver,
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned(
            top: 5,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle),
              child: IconButton(
                icon:
                    Icon(Icons.bookmark_outline, color: Colors.white),
                onPressed: () {
                  // Handle bookmark action
                },
              ),
            ),
          ),
          // Text Overlay (Left Center)
        ],
      ),
    );
  }
}
