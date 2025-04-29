import 'package:auto_route/auto_route.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/service/notification_service.dart';
import 'package:metropolitan_museum/app/common/service/object_box_service.dart';
import 'package:metropolitan_museum/app/common/widgets/logo_image.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await scheduleInitialNotification(context); // <-- context burada güvenli
      context.replaceRoute(const MainRoute());
    });
  }

  Future<void> scheduleInitialNotification(BuildContext context) async {
    List<DepartmentModel> models = getIt<ObjectBoxService>().departmentBox.getAll();
    String bodyText = "";
    if (models.isNotEmpty) {
      // Rastgele bir department seç
      final random = (models.length == 1) ? 0 : (DateTime.now().millisecondsSinceEpoch % models.length);
      bodyText = "Visit the ${models[random].displayName} department today!";
    }

    // await NotificationService().scheduleDailyNotification(
    //   id: 0,
    //   title: 'The Metropolitan Museum of Art',
    //   body: departmentName,
    //   payload: 'daily_reminder',
    //   hour: 12,
    //   minute: 0,
    //   context: context,
    // );
    NotiService().scheduleNotification(
      title: "The Metropolitan Museum of Art",
      body: bodyText,
      hour: 10,
      minute: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LogoImage()),
    );
  }
}
