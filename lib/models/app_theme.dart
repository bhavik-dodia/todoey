import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  Color _accentColor = Colors.blueAccent;

  Color get accentColor => _accentColor;

  set accentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }
}
