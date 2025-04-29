import 'package:metropolitan_museum/app/common/config/config.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/service/notification_service.dart';
import 'package:metropolitan_museum/core/helpers/device/device_info_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceInfoHelper.instance.init();
    Config.currentEnvironment = Environment.development;
    ServiceLocator().setup();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Bildirim servisini başlat

    NotiService().initNotification();
    // Android için pil optimizasyonu iznini kontrol et
    if (Platform.isAndroid) {
      final status = await Permission.ignoreBatteryOptimizations.status;
      if (!status.isGranted) {
        await Permission.ignoreBatteryOptimizations.request();
      }
    }

    // Context'e erişim için bir widget oluşturmamız gerekecek
    // Şimdilik bu kısmı bir widget içinde yapmanı öneriyorum
  }
}
