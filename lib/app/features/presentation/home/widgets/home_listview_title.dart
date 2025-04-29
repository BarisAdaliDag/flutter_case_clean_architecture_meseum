// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_strings.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeListViewHeader extends StatelessWidget {
  const HomeListViewHeader({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TxStyleHelper.subheadingBold.copyWith(
                  fontSize: (19.0).sp,
                  color:
                      Theme.of(context).brightness == Brightness.dark ? AppColors.whiteBottomAppbar : AppColors.black,
                  fontWeight: FontWeight.w600)),
          InkWell(
            onTap: onTap,
            child: const Row(
              children: [
                Text(
                  AppStrings.seeAll,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
