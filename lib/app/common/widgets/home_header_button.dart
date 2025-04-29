// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';

class HomeHeaderButton extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  const HomeHeaderButton({
    super.key,
    required this.ontap,
    required this.title,
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
        title,
        style: TxStyleHelper.body.copyWith(color: AppColors.white),
      ),
    );
  }
}
