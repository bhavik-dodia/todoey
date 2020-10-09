import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:Todoey/main.dart';

class NotificationHelper {

  Future<void> _showScheduledNotificationWithDefaultSound(
      int id, String subtitle, int time) async {
    var platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          'id',
          'notification',
          'task notification',
          importance: Importance.max,
          priority: Priority.max,
          category: 'CATEGORY_REMINDER',
          icon: 'appicon',
          largeIcon: DrawableResourceAndroidBitmap('notification_icon'),
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
    _showScheduledNotificationWithDefaultSound(id, task, t);
  }
}
