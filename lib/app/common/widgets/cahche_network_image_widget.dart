import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  const CacheNetworkImageWidget({
    super.key,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
  });

  final String image;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
    );
  }
}
