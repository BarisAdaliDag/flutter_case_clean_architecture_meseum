enum AppImage {
  logo,
}

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
