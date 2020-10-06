import 'package:Todoey/screens/task_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:Todoey/models/task_data.dart';
import 'package:Todoey/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

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
                  return OpenContainer(
                    closedElevation: 0.0,
                    closedColor: Theme.of(context).canvasColor,
                    openColor: Theme.of(context).canvasColor,
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 500),
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    openBuilder: (contex, closeContainer) {
                      return TaskDetails(
                        title: task.name,
                        description: task.description,
                        time: task.time,
                        onBack: closeContainer,
                        onDelete: () {
                          taskData.deleteTask(task);
                          Toast.show('Task removed...', context,
                              gravity: Toast.BOTTOM);
                          closeContainer();
                        },
                      );
                    },
                    closedBuilder: (contex, openContainer) {
                      return TaskTile(
                        taskTitle: task.name,
                        isChecked: task.isDone,
                        toggleCheckbox: (checkboxState) {
                          taskData.updateTask(task);
                        },
                        onTap: openContainer,
                        onLongPress: () {
                          taskData.deleteTask(task);
                          Toast.show('Task removed...', context,
                              gravity: Toast.BOTTOM);
                        },
                      );
                    },
                  );
                });
      },
    );
  }
}
