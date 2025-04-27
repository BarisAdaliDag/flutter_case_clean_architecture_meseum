enum AppImage {
  logo,
  header_collection,
  header_home,
  img_info_01,
  img_info_02,
  img_info_03,
  nodata_black,
  nodata_white
}

extension AppImagePath on AppImage {
  String get path => 'assets/images/$name.png';
}

enum AppLottie {
  loading,
}

extension AppLottiePath on AppLottie {
  String get path => 'assets/lotties/$name.json';
}
