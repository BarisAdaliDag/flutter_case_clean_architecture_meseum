// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/features/presentation/home/view/home_view.dart';

import '../../../../common/constants/text_style_helper.dart';

class TheMetHeader extends StatelessWidget {
  const TheMetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppImage.header_home.path,
              fit: BoxFit.cover,
            ),
          ),

          // Text and button
          Positioned(
            left: 16,
            bottom: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome\nto The Met',
                    style: TxStyleHelper.heading3.copyWith(color: AppColors.white, fontSize: (25.0).sp)),
                const Gap(10),
                HomeHeaderButton(
                  ontap: () {
                    context.tabsRouter.setActiveIndex(1);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeHeaderButton extends StatelessWidget {
  final VoidCallback ontap;
  const HomeHeaderButton({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.redValencia,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <- köşe yuvarlaklığı burada
        ),
      ),
      onPressed: ontap,
      child: Text(
        'Explore Collection',
        style: TxStyleHelper.body.copyWith(color: AppColors.white),
      ),
    );
  }
}
