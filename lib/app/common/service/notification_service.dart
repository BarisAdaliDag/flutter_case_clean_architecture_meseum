import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Zaman dilimini başlat
    tz.initializeTimeZones();

    // Android ve iOS için başlatma ayarları
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); // Uygulama ikon adını kontrol et

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Bildirim sistemini başlat
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          debugPrint('Bildirim payload: ${response.payload}');
        }
        debugPrint('Bildirim alındı: ${response.notificationResponseType}');
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Android 13+ için bildirim izni
    if (Platform.isAndroid) {
      final androidPlugin =
          _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }
    }

    // Uygulama açıkken bildirimlerin görünmesi için (iOS özel ayarı)
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int hour,
    required int minute,
    required BuildContext context, // Dialog için context ekledik
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_notification_channel_id',
            'Daily Notifications',
            channelDescription: 'Daily scheduled notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true, // foreground görünürlük için
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time, // Günlük tekrar
        payload: payload,
      );
    } catch (e) {
      debugPrint('Bildirim planlama hatası: $e');
      if (e.toString().contains('exact_alarms_not_permitted')) {
        // Kullanıcıya dialog göster
        await _showExactAlarmPermissionDialog(context);
      }
    }
  }

  Future<void> _showExactAlarmPermissionDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification request'),
        content: const Text(
            'You need to enable the ‘Alarms and Reminders’ permission for scheduled notifications. You can grant the permission by going to Settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Ayarlar ekranına yönlendirme
              await openAppSettings();
            },
            child: const Text('Ayarlar'),
          ),
        ],
      ),
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

// Arka planda notification tıklaması yakalama (opsiyonel)
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('Arka planda bildirime tıklandı: ${notificationResponse.payload}');
}
