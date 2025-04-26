import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold, // Başlık bold olacak
                color: Theme.of(context).brightness != Brightness.dark ? AppColors.smokyBlack : AppColors.lavender,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal, // Değer normal olacak
                color: Theme.of(context).brightness != Brightness.dark ? AppColors.smokyBlack : AppColors.lavender,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
