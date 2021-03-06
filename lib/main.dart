import 'dart:io';

import 'package:Todoey/models/app_theme.dart';
import 'package:Todoey/screens/home_page.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'models/task_data.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

const MethodChannel platform = MethodChannel('todoey.flutter.dev/location');

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future getDeviceInfo() async {
  if (Platform.isAndroid) {
    return await deviceInfoPlugin.androidInfo;
  } else {
    return await deviceInfoPlugin.iosInfo;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppTheme(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todoey',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Provider.of<AppTheme>(context).accentColor,
          colorScheme: ColorScheme.light().copyWith(
            primary: Provider.of<AppTheme>(context).accentColor,
            secondary: Provider.of<AppTheme>(context).accentColor,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          accentColor: Provider.of<AppTheme>(context).accentColor,
          colorScheme: ColorScheme.dark().copyWith(
            primary: Provider.of<AppTheme>(context).accentColor,
            secondary: Provider.of<AppTheme>(context).accentColor,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
