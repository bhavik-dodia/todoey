import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  NotificationHelper() {
    tz.initializeTimeZones();
    _configureLocalTimeZone();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings()));
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MethodChannel platform = MethodChannel('todoey.flutter.dev/location');

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _showNotificationWithDefaultSound(
      int id, String subtitle, int time) async {
    var platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          'id1',
          'notification',
          'tasknotification',
          importance: Importance.max,
          priority: Priority.max,
          category: 'CATEGORY_REMINDER',
          largeIcon:  DrawableResourceAndroidBitmap('ic_launcher'),
          enableLights: true,
          playSound: true,
          channelShowBadge: true,
          enableVibration: true,
          ledColor: Colors.white,
          ledOnMs: 1000,
          ledOffMs: 500,
          visibility: NotificationVisibility.secret,
        ),
        iOS: IOSNotificationDetails());

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Reminder',
      subtitle,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: time)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: subtitle,
      androidAllowWhileIdle: true,
    );
  }

  void sendNotification(int id, String task, int t) {
    _showNotificationWithDefaultSound(id, task, t);
  }
}
