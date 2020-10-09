import 'package:flutter/material.dart';

class MenuItem {
  final IconData iconData;
  final String name;
  final Function action;
  MenuItem({this.iconData, this.name, this.action});
}
