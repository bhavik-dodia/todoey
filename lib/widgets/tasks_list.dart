import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:Todoey/models/task_data.dart';
import 'package:Todoey/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return taskData.taskCount == 0
            ? ListView(
                children: [
                  Image.asset('images/Method_Draw_Image.png'),
                  SizedBox(height: 30.0),
                  Text(
                    'You\'re all caught up!\nAdd a new task',
                    style: GoogleFonts.merienda(),
                    textAlign: TextAlign.center,
                  )
                ],
              )
            : ListView.builder(
                itemCount: taskData.taskCount,
                itemBuilder: (contex, index) {
                  final task = taskData.tasks[index];
                  // NotificationHelper().sendNotification(index, task.name, index+1);
                  return TaskTile(
                    taskTitle: task.name,
                    isChecked: task.isDone,
                    toggleCheckbox: (checkboxState) {
                      taskData.updateTask(task);
                    },
                    onLongPress: () {
                      taskData.deleteTask(task);
                      Toast.show('Task removed...', context,
                          gravity: Toast.BOTTOM);
                    },
                  );
                });
      },
    );
  }
}
