import 'package:Todoey/models/task_data.dart';
import 'package:Todoey/screens/edit_task.dart';
import 'package:Todoey/screens/task_details.dart';
import 'package:Todoey/widgets/task_tile.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class TasksList extends StatefulWidget {
  final Function onBottom;
  final Function onTop;

  TasksList({this.onBottom, this.onTop});
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.onBottom();
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.onTop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                controller: _scrollController,
                itemCount: taskData.taskCount,
                itemBuilder: (contex, index) {
                  final task = taskData.tasks[index];
                  return OpenContainer(
                    closedElevation: 0.0,
                    closedColor: Theme.of(context).canvasColor,
                    openColor: Theme.of(context).canvasColor,
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 300),
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    openBuilder: (contex, closeContainer) {
                      return TaskDetails(
                        title: task.name,
                        description: task.description,
                        time: task.time,
                        onBack: closeContainer,
                        onEdit: () {
                          closeContainer();
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => EditTask(
                                task: task,
                                index: index,
                                title: task.name,
                                description: task.description),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            isScrollControlled: true,
                          );
                        },
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
                        time: task.time,
                        isChecked: task.isDone,
                        toggleCheckbox: (checkboxState) {
                          taskData.toggleTask(task);
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
                },
              );
      },
    );
  }
}
