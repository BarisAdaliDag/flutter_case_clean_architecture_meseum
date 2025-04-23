enum AppIcons {
  back,
  searchSelected,
  searchUnselected,
  tabbarCollectionSelected,
  tabbarCollectionUnselected,
  tabbarHomeSelected,
  tabbarHomeUnselected,
  tabbarInfoSelected,
  tabbarInfoUnselected,
  imgForward,
}

extension AppIconsExtension on AppIcons {
  String get fileName {
    switch (this) {
      case AppIcons.back:
        return 'back';
      case AppIcons.searchSelected:
        return 'search_selected';
      case AppIcons.searchUnselected:
        return 'search_unselected';
      case AppIcons.tabbarCollectionSelected:
        return 'tabbar_collection_selected';
      case AppIcons.tabbarCollectionUnselected:
        return 'tabbar_collection_unselected';
      case AppIcons.tabbarHomeSelected:
        return 'tabbar_home_selected';
      case AppIcons.tabbarHomeUnselected:
        return 'tabbar_home_unselected';
      case AppIcons.tabbarInfoSelected:
        return 'tabbar_info_selected';
      case AppIcons.tabbarInfoUnselected:
        return 'tabbar_info_unselected';
      case AppIcons.imgForward:
        return 'img_forward';
    }
  }

  String get assetPath => 'assets/icons/$fileName.png';
}
