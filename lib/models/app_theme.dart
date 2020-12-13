import 'dart:collection';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  List<MaterialAccentColor> _colors = Colors.accents;
  int _currentIndex = 5;

  Color _accentColor = Colors.blueAccent;

  UnmodifiableListView<MaterialAccentColor> get colors =>
      UnmodifiableListView(_colors);

  Color get accentColor => _accentColor;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    _accentColor = _colors[index];
    notifyListeners();
  }
}
