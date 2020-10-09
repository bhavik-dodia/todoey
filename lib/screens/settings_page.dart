import 'package:Todoey/models/task_data.dart';
import 'package:Todoey/widgets/color_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final List<MaterialAccentColor> colors = Colors.accents;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 40.0, bottom: 15.0),
      physics: BouncingScrollPhysics(),
      children: [
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
            itemCount: colors.length,
            itemBuilder: (context, index) => ColorBox(
              color: colors[index],
            ),
          ),
        ),
        Divider(),
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
        ListTile(
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
          trailing: Switch.adaptive(
            value: Provider.of<TaskData>(context).deleteOnComplete,
            onChanged: (value) => Provider.of<TaskData>(context, listen: false)
                .deleteOnComplete = value,
          ),
        ),
      ],
    );
  }
}
