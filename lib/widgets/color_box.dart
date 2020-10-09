import 'package:Todoey/models/app_theme.dart';
import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorBox extends StatelessWidget {
  final Color color;

  ColorBox({this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: SquircleBorder(),
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Provider.of<AppTheme>(context, listen: false).accentColor = color;
        },
        child: SizedBox(
          height: 40.0,
          width: 40.0,
        ),
      ),
    );
  }
}
