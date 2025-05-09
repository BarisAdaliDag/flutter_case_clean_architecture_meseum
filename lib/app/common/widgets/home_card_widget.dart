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
  final VoidCallback? onTap;

  const HomeCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isImageLocal = false,
    this.imageHeight = 200,
    this.imageWidth = double.infinity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.greyHomeBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: image.isNotEmpty
                  ? CacheNetworkImageWidget(image: image, imageWidth: imageWidth, imageHeight: imageHeight)
                  : Container(
                      width: imageWidth,
                      height: imageHeight,
                      color: AppColors.iconInactiveDark,
                      child: const Icon(Icons.image_not_supported)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.smokyBlack
                              : AppColors.greyNickel),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    title,
                    style: TxStyleHelper.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).brightness == Brightness.dark ? AppColors.smokyBlack : AppColors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
