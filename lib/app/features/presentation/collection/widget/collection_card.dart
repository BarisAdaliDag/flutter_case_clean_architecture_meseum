// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/features/presentation/home/view/home_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CollectionCard extends StatelessWidget {
  final String image;
  final String title;
  final String? id;

  const CollectionCard({
    super.key,
    required this.image,
    required this.title,
    this.id = "1",
  });

  @override
  Widget build(BuildContext context) {
    int idx = int.parse(id ?? "1");
    if (idx > 22) {
      idx = 1;
    }

    return Card(
      color: AppColors.greyHomeBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              "assets/images/img_collection_${(idx.toString())}.png",
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TxStyleHelper.body.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp),
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
