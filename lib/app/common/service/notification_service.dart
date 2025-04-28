// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     // Zaman dilimini başlat
//     tz.initializeTimeZones();

//     // Android ve iOS için başlatma ayarları
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon'); // Uygulama ikon adını kontrol et

//     const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     // Bildirim sistemini başlat
//     await _notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         if (response.payload != null) {
//           debugPrint('Bildirim payload: ${response.payload}');
//         }
//         debugPrint('Bildirim alındı: ${response.notificationResponseType}');
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );

//     // Android 13+ için bildirim izni
//     if (Platform.isAndroid) {
//       final androidPlugin =
//           _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//       if (androidPlugin != null) {
//         await androidPlugin.requestNotificationsPermission();
//       }
//     }

//     // Uygulama açıkken bildirimlerin görünmesi için (iOS özel ayarı)
//     await _notificationsPlugin
//         .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(alert: true, badge: true, sound: true);
//   }

//   Future<void> scheduleDailyNotification({
//     required int id,
//     required String title,
//     required String body,
//     required String payload,
//     required int hour,
//     required int minute,
//     required BuildContext context, // Dialog için context ekledik
//   }) async {
//     try {
//       await _notificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         _nextInstanceOfTime(hour, minute),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'daily_notification_channel_id',
//             'Daily Notifications',
//             channelDescription: 'Daily scheduled notifications',
//             importance: Importance.max,
//             priority: Priority.high,
//           ),
//           iOS: DarwinNotificationDetails(
//             presentAlert: true, // foreground görünürlük için
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time, // Günlük tekrar
//         payload: payload,
//       );
//     } catch (e) {
//       debugPrint('Bildirim planlama hatası: $e');
//       if (e.toString().contains('exact_alarms_not_permitted')) {
//         // Kullanıcıya dialog göster
//         await _showExactAlarmPermissionDialog(context);
//       }
//     }
//   }

//   Future<void> _showExactAlarmPermissionDialog(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Notification request'),
//         content: const Text(
//             'You need to enable the ‘Alarms and Reminders’ permission for scheduled notifications. You can grant the permission by going to Settings.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('İptal'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               // Ayarlar ekranına yönlendirme
//               await openAppSettings();
//             },
//             child: const Text('Ayarlar'),
//           ),
//         ],
//       ),
//     );
//   }

//   tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       hour,
//       minute,
//     );
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
// }

// // Arka planda notification tıklaması yakalama (opsiyonel)
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   debugPrint('Arka planda bildirime tıklandı: ${notificationResponse.payload}');
// }

//==============================================================================

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return; // prevent re-initialization

//init timezonehandling
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // prepare android init settings
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    // prepare ios init settings
    const initSettingsIOS = DarwinInitializationSettings();

    // prepare overall init settings
    const initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initializationSettings);

    _isInitialized = true;
  }

  // NOTIFICATIONS DETAIL SETUP

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ), // AndroidNotificationDetails
      iOS: DarwinNotificationDetails(),
    ); // NotificationDetails
  }

  // SHOW NOTIFICATION

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(),
    );
  }

/*
Schedule a notification at a specified time (e.g., 11pm)

- hour (0-23)
- minute (0-59)

*/

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    // Get the current date/time in device's local timezone
    final now = tz.TZDateTime.now(tz.local);

    // Create a date/time for today at the specified hour/min
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
// SCHEDULE NOTIFICATION
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(),
      // iOS specific: Use exact time specified (vs relative time)
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      // Android specific: Allow notification while device is in low-power mode
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // Make notification repeat DAILY at same time
      //! time gunluk calisma ayari,baska ayarlarda var
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print("Notification Scaculed");
  }

// CANCEL ALL NOTIFICATIONS
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}
