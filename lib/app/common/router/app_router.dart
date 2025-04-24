import 'package:auto_route/auto_route.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/view/setting_view.dart';

import '../../features/presentation/collection/collection_view.dart';
import '../../features/presentation/home/view/home_view.dart';
import '../../features/presentation/info/info_view.dart';
import '../../features/presentation/main/view/main_view.dart';
import '../../features/presentation/splash/view/splash_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: MainRoute.page,
          // initial: true,
          children: [
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(
              page: CollectionRoute.page,
            ),
            AutoRoute(
              page: InfoRoute.page,
            ),
          ],
        ),
      ];
}
