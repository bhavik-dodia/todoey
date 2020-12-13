import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String time;
  final Function toggleCheckbox;
  final Function onLongPress;
  final Function onTap;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.time,
      this.toggleCheckbox,
      this.onLongPress,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
      title: Text(
        taskTitle,
        style: GoogleFonts.merienda(
          fontSize: 18.0,
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        time,
        style: GoogleFonts.merienda(
          fontSize: 12.0,
        ),
      ),
      trailing: Checkbox(
          visualDensity: VisualDensity.compact,
          activeColor: Theme.of(context).accentColor,
          value: isChecked,
          onChanged: toggleCheckbox),
    );
  }
}
