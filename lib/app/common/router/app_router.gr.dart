// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CollectionView]
class CollectionRoute extends PageRouteInfo<void> {
  const CollectionRoute({List<PageRouteInfo>? children})
      : super(
          CollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CollectionView();
    },
  );
}

/// generated route for
/// [HomeSeeAllView]
class HomeSeeAllRoute extends PageRouteInfo<HomeSeeAllRouteArgs> {
  HomeSeeAllRoute({
    Key? key,
    required bool isFamous,
    List<PageRouteInfo>? children,
  }) : super(
          HomeSeeAllRoute.name,
          args: HomeSeeAllRouteArgs(
            key: key,
            isFamous: isFamous,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeSeeAllRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeSeeAllRouteArgs>();
      return HomeSeeAllView(
        key: args.key,
        isFamous: args.isFamous,
      );
    },
  );
}

class HomeSeeAllRouteArgs {
  const HomeSeeAllRouteArgs({
    this.key,
    required this.isFamous,
  });

  final Key? key;

  final bool isFamous;

  @override
  String toString() {
    return 'HomeSeeAllRouteArgs{key: $key, isFamous: $isFamous}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [InfoView]
class InfoRoute extends PageRouteInfo<void> {
  const InfoRoute({List<PageRouteInfo>? children})
      : super(
          InfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'InfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InfoView();
    },
  );
}

/// generated route for
/// [MainView]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainView();
    },
  );
}

/// generated route for
/// [SettingView]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute({List<PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}
