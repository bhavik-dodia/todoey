import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:Todoey/models/task_data.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 15.0, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            Text(
              'New Task',
              style: GoogleFonts.merienda(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
                hintText: 'Enter task',
                hintStyle: GoogleFonts.merienda(
                  fontSize: 20.0,
                ),
              ),
              onChanged: (value) {
                newTaskTitle = value;
              },
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.sentences,
              style: GoogleFonts.merienda(
                fontSize: 20.0,
              ),
            ),
            MaterialButton(
              onPressed: () {
                if (newTaskTitle != null) {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskTitle);
                  Toast.show('Task added...', context, gravity: Toast.BOTTOM);
                  Navigator.of(context).pop();
                } else {
                  Toast.show('Please enter a task', context,
                      gravity: Toast.TOP, duration: Toast.LENGTH_SHORT);
                }
              },
              elevation: 0.0,
              color: Colors.blueAccent.withOpacity(0.3),
              textColor: Colors.blueAccent,
              highlightColor: Colors.blueAccent.withOpacity(0.4),
              splashColor: Colors.blueAccent.withOpacity(0.5),
              highlightElevation: 0.0,
              height: 45.0,
              // padding: EdgeInsets.symmetric(horizontal: 60.0),
              shape: SquircleBorder(superRadius: 20),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(18.0))),
              child: Text(
                'Add',
                style: GoogleFonts.merienda(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
