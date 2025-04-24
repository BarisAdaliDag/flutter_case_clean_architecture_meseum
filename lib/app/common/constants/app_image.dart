enum AppImage { logo, header_collection, header_home, img_info_01, img_info_02, img_info_03 }

extension AppImagePath on AppImage {
  String get path => 'assets/images/$name.png';
}

enum AppLottie {
  success,
  loading,
}

extension AppLottiePath on AppLottie {
  String get path => 'assets/lottie/$name.json';
}
