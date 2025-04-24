import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            AppImage.header_collection.path,
            fit: BoxFit.cover,
          ),

          // Padding içinde yazı
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.center,
                'Travel around the\nworld and across \n5,000 years of history \nthrough 490,000+\nworks of art.',
                style: TxStyleHelper.heading3.copyWith(
                  color: AppColors.white,
                  fontSize: 23.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
