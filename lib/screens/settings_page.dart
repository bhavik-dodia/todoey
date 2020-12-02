import 'package:Todoey/models/app_theme.dart';
import 'package:Todoey/models/task_data.dart';
import 'package:Todoey/widgets/color_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 15.0),
      physics: BouncingScrollPhysics(),
      children: [
        Divider(
          height: 30.0,
          thickness: 4.0,
          indent: MediaQuery.of(context).size.width * 0.45,
          endIndent: MediaQuery.of(context).size.width * 0.45,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Themes',
            style: GoogleFonts.merienda(
              fontSize: 16.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        Container(
          height: 80.0,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: Provider.of<AppTheme>(context).colors.length,
            itemBuilder: (context, index) => ColorBox(
              color: Provider.of<AppTheme>(context).colors[index],
              colorIndex: index,
            ),
          ),
        ),
        Divider(indent: 10.0, endIndent: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Advanced',
            style: GoogleFonts.merienda(
              fontSize: 16.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        SwitchListTile.adaptive(
          onChanged: (value) => Provider.of<TaskData>(context, listen: false)
              .deleteOnComplete = value,
          value: Provider.of<TaskData>(context).deleteOnComplete,
          title: Text(
            'Delete when completed',
            style: GoogleFonts.merienda(
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            'Tasks will be deleted once completed',
            style: GoogleFonts.merienda(),
          ),
        ),
        Divider(indent: 10.0, endIndent: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Pro Tip',
            style: GoogleFonts.merienda(
              fontSize: 16.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Tap and hold on a task to delete',
            style: GoogleFonts.merienda(
              fontSize: 18.0,
            ),
          ),
        )
      ],
    );
  }
}
