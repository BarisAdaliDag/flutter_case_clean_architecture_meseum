// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/common/widgets/cahche_network_image_widget.dart';

class HomeCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isImageLocal;
  final double imageHeight;
  final double imageWidth;

  const HomeCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isImageLocal = false,
    this.imageHeight = 200,
    this.imageWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.greyHomeBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: image.isNotEmpty
                ? CacheNetworkImageWidget(image: image, imageWidth: imageWidth, imageHeight: imageHeight)
                : SizedBox(width: imageWidth, height: imageHeight, child: const Icon(Icons.image_not_supported)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 40,
                  child: Text(
                    subtitle,
                    style: const TextStyle(color: AppColors.greyNickel),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(4),
                Text(
                  title,
                  style: TxStyleHelper.body.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
