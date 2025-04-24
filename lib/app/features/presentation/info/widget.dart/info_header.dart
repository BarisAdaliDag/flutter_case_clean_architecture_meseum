import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key});

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
            AppImage.img_info_01.path,
            fit: BoxFit.cover,
          ),

          // Padding içinde yazı
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.center,
                'The Met presents\nover 5,000 years of \nart from around the \ntworld for everyone to\nexperience and enjoy.',
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
