import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {

  List<MaterialAccentColor> colors = Colors.accents;
  var map ={};

  Color _accentColor = Colors.blueAccent;

  Color get accentColor => _accentColor;

   setMap(){
    colors.forEach((element) => map[element.toString()] = element);
    print(Colors.blueAccent);
  }
  set accentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }
}
