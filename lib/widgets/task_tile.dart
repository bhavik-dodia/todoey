import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function toggleCheckbox;
  final Function onLongPress;

  TaskTile(
      {this.isChecked, this.taskTitle, this.toggleCheckbox, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      onTap: () {
        toggleCheckbox(isChecked);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      title: Text(
        taskTitle,
        style: GoogleFonts.merienda(
          fontSize: 18.0,
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
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
