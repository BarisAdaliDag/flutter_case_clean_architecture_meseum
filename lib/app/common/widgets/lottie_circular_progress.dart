import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';

class LottieCircularProgress extends StatelessWidget {
  const LottieCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppLottie.loading.path,
        width: 40,
        height: 40,
        fit: BoxFit.fill,
      ),
    );
  }
}
