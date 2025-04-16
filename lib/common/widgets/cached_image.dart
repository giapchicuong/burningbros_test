import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width = 60,
    this.height = 60,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }
}
