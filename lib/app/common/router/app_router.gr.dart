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
/// [DepartmentDetailView]
class DepartmentDetailRoute extends PageRouteInfo<DepartmentDetailRouteArgs> {
  DepartmentDetailRoute({
    Key? key,
    required int departmentId,
    required String departmentName,
    List<PageRouteInfo>? children,
  }) : super(
          DepartmentDetailRoute.name,
          args: DepartmentDetailRouteArgs(
            key: key,
            departmentId: departmentId,
            departmentName: departmentName,
          ),
          initialChildren: children,
        );

  static const String name = 'DepartmentDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DepartmentDetailRouteArgs>();
      return DepartmentDetailView(
        key: args.key,
        departmentId: args.departmentId,
        departmentName: args.departmentName,
      );
    },
  );
}

class DepartmentDetailRouteArgs {
  const DepartmentDetailRouteArgs({
    this.key,
    required this.departmentId,
    required this.departmentName,
  });

  final Key? key;

  final int departmentId;

  final String departmentName;

  @override
  String toString() {
    return 'DepartmentDetailRouteArgs{key: $key, departmentId: $departmentId, departmentName: $departmentName}';
  }
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
/// [ObjectDetailView]
class ObjectDetailRoute extends PageRouteInfo<ObjectDetailRouteArgs> {
  ObjectDetailRoute({
    Key? key,
    required ObjectModel objectModel,
    List<PageRouteInfo>? children,
  }) : super(
          ObjectDetailRoute.name,
          args: ObjectDetailRouteArgs(
            key: key,
            objectModel: objectModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ObjectDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ObjectDetailRouteArgs>();
      return ObjectDetailView(
        key: args.key,
        objectModel: args.objectModel,
      );
    },
  );
}

class ObjectDetailRouteArgs {
  const ObjectDetailRouteArgs({
    this.key,
    required this.objectModel,
  });

  final Key? key;

  final ObjectModel objectModel;

  @override
  String toString() {
    return 'ObjectDetailRouteArgs{key: $key, objectModel: $objectModel}';
  }
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
