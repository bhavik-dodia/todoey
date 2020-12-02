import 'package:Todoey/helpers/notification_helper.dart';
import 'package:Todoey/models/squircle_border.dart';
import 'package:Todoey/models/task.dart';
import 'package:Todoey/models/task_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class EditTask extends StatefulWidget {
  final Task task;
  final int index;
  final String title;
  final String description;

  EditTask({this.task, this.index, this.title, this.description});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String reminderTime = 'No Reminder';

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController titleController;
  TextEditingController descriptionController;

  bool isDesc = false;

  var seconds = 0;

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) return true;
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
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15.0,
        right: 15.0,
      ),
      children: [
        Divider(
          height: 30.0,
          thickness: 4.0,
          indent: MediaQuery.of(context).size.width * 0.41,
          endIndent: MediaQuery.of(context).size.width * 0.41,
        ),
        Text(
          'Edit Task',
          textAlign: TextAlign.center,
          style: GoogleFonts.merienda(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
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
          controller: titleController,
          cursorColor: Theme.of(context).accentColor,
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.sentences,
          style: GoogleFonts.merienda(
            fontSize: 20.0,
          ),
        ),
        Visibility(
          visible: isDesc,
          child: TextField(
            autofocus: true,
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
            controller: descriptionController,
            cursorColor: Theme.of(context).accentColor,
            textAlign: TextAlign.left,
            maxLines: 3,
            minLines: 1,
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
                color: Theme.of(context).accentColor.withOpacity(0.3),
                child: IconButton(
                  tooltip: 'Set Description',
                  icon: FaIcon(FontAwesomeIcons.alignLeft,
                      color: Theme.of(context).accentColor),
                  highlightColor:
                      Theme.of(context).accentColor.withOpacity(0.4),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.5),
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
                color: Theme.of(context).accentColor.withOpacity(0.3),
                child: IconButton(
                    tooltip: 'Set Reminder',
                    icon: FaIcon(FontAwesomeIcons.calendarAlt,
                        color: Theme.of(context).accentColor),
                    highlightColor:
                        Theme.of(context).accentColor.withOpacity(0.4),
                    splashColor: Theme.of(context).accentColor.withOpacity(0.5),
                    onPressed: () => _selectDate(context)),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: () {
                  if (titleController.text != widget.title ||
                      descriptionController.text != widget.description) {
                    if (seconds > 0) {
                      NotificationHelper().sendNotification(
                          widget.index, titleController.text, seconds);
                      Toast.show('Reminder set successfully...', context,
                          gravity: Toast.TOP);
                      reminderTime =
                          DateFormat('EEE, MMM d hh:mm a').format(selectedDate);
                    }
                    Provider.of<TaskData>(context, listen: false).updateTask(
                        widget.task,
                        titleController.text,
                        descriptionController.text,
                        reminderTime);
                    Toast.show('Task updated...', context,
                        gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                  } else
                    Toast.show('Please edit title or description', context,
                        gravity: Toast.TOP);
                },
                elevation: 0.0,
                color: Theme.of(context).accentColor.withOpacity(0.3),
                textColor: Theme.of(context).accentColor,
                highlightColor: Theme.of(context).accentColor.withOpacity(0.4),
                splashColor: Theme.of(context).accentColor.withOpacity(0.5),
                highlightElevation: 0.0,
                height: 53.0,
                shape: SquircleBorder(superRadius: 15),
                child: Text(
                  'Edit',
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
