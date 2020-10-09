import 'package:Todoey/widgets/color_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Themes',
                style: GoogleFonts.merienda(
                  fontSize: 18.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ColorBox(color: Colors.blueAccent),
                  ColorBox(color: Colors.greenAccent),
                  ColorBox(color: Colors.deepOrangeAccent),
                  ColorBox(color: Colors.pinkAccent),
                  ColorBox(color: Colors.purpleAccent),
                ],
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
