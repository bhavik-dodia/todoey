import 'package:Todoey/helpers/notification_helper.dart';
import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:Todoey/models/task_data.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String newTaskTitle = '';
  String newDescription = '';
  String reminderTime = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  bool isDesc = false;

  var seconds = 0;

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      fieldLabelText: 'Remind me on',
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
      _selectTime();
    }
  }

  _selectTime() async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
        selectedDate = selectedDate.add(
            Duration(hours: selectedTime.hour, minutes: selectedTime.minute));
        seconds = selectedDate.difference(DateTime.now()).inSeconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          top: 15.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15.0,
          right: 15.0),
      children: [
        Text(
          'New Task',
          textAlign: TextAlign.center,
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
            setState(() {
              newTaskTitle = value;
            });
          },
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.sentences,
          style: GoogleFonts.merienda(
            fontSize: 20.0,
          ),
        ),
        Visibility(
          visible: isDesc,
          child: TextField(
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              filled: false,
              hintText: 'Enter task description',
              hintStyle: GoogleFonts.merienda(
                fontSize: 18.0,
              ),
            ),
            onChanged: (value) {
              setState(() {
                newDescription = value;
              });
            },
            textAlign: TextAlign.left,
            textCapitalization: TextCapitalization.sentences,
            style: GoogleFonts.merienda(
              fontSize: 18.0,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Card(
                elevation: 0.0,
                clipBehavior: Clip.antiAlias,
                shape: SquircleBorder(),
                color: Colors.blueAccent.withOpacity(0.3),
                child: IconButton(
                  tooltip: 'Set Description',
                  icon: Icon(Icons.description, color: Colors.blueAccent),
                  highlightColor: Colors.blueAccent.withOpacity(0.4),
                  splashColor: Colors.blueAccent.withOpacity(0.5),
                  onPressed: () => setState(() {
                    isDesc = !isDesc;
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                elevation: 0.0,
                clipBehavior: Clip.antiAlias,
                shape: SquircleBorder(),
                color: Colors.blueAccent.withOpacity(0.3),
                child: IconButton(
                    tooltip: 'Set Reminder',
                    icon: Icon(Icons.event, color: Colors.blueAccent),
                    highlightColor: Colors.blueAccent.withOpacity(0.4),
                    splashColor: Colors.blueAccent.withOpacity(0.5),
                    onPressed: () => _selectDate(context)),
              ),
            ),
            // Card(
            //   elevation: 0.0,
            //   clipBehavior: Clip.antiAlias,
            //   shape: SquircleBorder(),
            //   color: Colors.blueAccent.withOpacity(0.3),
            //   child: IconButton(
            //     tooltip: 'Add Task',
            //     icon: Icon(Icons.add, color: Colors.blueAccent),
            //     highlightColor: Colors.blueAccent.withOpacity(0.4),
            //     splashColor: Colors.blueAccent.withOpacity(0.5),
            //     iconSize: 30.0,
            //     onPressed: () {
            //       if (newTaskTitle != null) {
            //         if (seconds > 0) {
            //           NotificationHelper().sendNotification(
            //               Provider.of<TaskData>(context, listen: false)
            //                       .tasks
            //                       .length +
            //                   1,
            //               newTaskTitle,
            //               seconds);
            //           Toast.show('Reminder set successfully...', context,
            //               backgroundColor: Colors.white,
            //               textColor: Colors.black,
            //               gravity: Toast.TOP);
            //           reminderTime = selectedDate.toString();
            //         }
            //         Provider.of<TaskData>(context, listen: false).addTask(
            //             newTaskTitle, newDescription, reminderTime);
            //         Toast.show('Task added...', context,
            //             backgroundColor: Colors.white,
            //             textColor: Colors.black,
            //             gravity: Toast.BOTTOM);
            //         Navigator.of(context).pop();
            //       } else {
            //         Toast.show('Please enter a task', context,
            //             backgroundColor: Colors.white,
            //             textColor: Colors.black,
            //             gravity: Toast.TOP);
            //       }
            //     },
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: () {
                  if (newTaskTitle != null) {
                    if (seconds > 0) {
                      NotificationHelper().sendNotification(
                          Provider.of<TaskData>(context, listen: false)
                                  .tasks
                                  .length +
                              1,
                          newTaskTitle,
                          seconds);
                      Toast.show('Reminder set successfully...', context,
                          gravity: Toast.TOP);
                      reminderTime = selectedDate.toString();
                    }
                    Provider.of<TaskData>(context, listen: false)
                        .addTask(newTaskTitle, newDescription, reminderTime);
                    Toast.show('Task added...', context, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                  } else {
                    Toast.show('Please enter a task', context,
                        gravity: Toast.TOP);
                  }
                },
                elevation: 0.0,
                color: Colors.blueAccent.withOpacity(0.3),
                textColor: Colors.blueAccent,
                highlightColor: Colors.blueAccent.withOpacity(0.4),
                splashColor: Colors.blueAccent.withOpacity(0.5),
                highlightElevation: 0.0,
                height: 55.0,
                shape: SquircleBorder(superRadius: 20),
                child: Text(
                  'Add',
                  style: GoogleFonts.merienda(
                      fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
