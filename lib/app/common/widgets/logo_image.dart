import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        width: 70,
        child: Image.asset(
          AppImage.logo.path,
        ));
  }
}
