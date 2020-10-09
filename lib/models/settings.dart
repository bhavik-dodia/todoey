import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Settings {
  bool autoDelete;

  Settings(this.autoDelete);

  Map toJson() => {'autoDelete': autoDelete,};

  factory Settings.fromJson(dynamic json) {
    return Settings(json['autoDelete']);
  }

   Settings loadSettings(String str) {
    return Settings.fromJson(jsonDecode(str));
  }

  static void saveSettings(Settings settings) {
    getApplicationDocumentsDirectory().then((Directory directory) {
      File('${directory.path}/settings.json')
          .writeAsStringSync(jsonEncode(settings));
      print(jsonEncode(settings));
    });
  }
}
