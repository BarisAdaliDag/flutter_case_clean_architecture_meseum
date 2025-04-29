import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';

class PageTransActionTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isButtonEnabled;

  const PageTransActionTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isButtonEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TxStyleHelper.body.copyWith(
          color: isButtonEnabled ? AppColors.redValencia : Colors.grey,
          decoration: TextDecoration.underline,
          decorationColor: isButtonEnabled ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
