import 'dart:io';
import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:Todoey/widgets/menu.dart';
import 'package:Todoey/widgets/tasks_list.dart';
import 'package:Todoey/screens/add_task.dart';
import 'package:Todoey/models/task_data.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 250);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _menuSlideAnimation;
  Animation<Offset> _homeSlideAnimation;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      File('${directory.path}/tasks.json').readAsString().then((value) => Provider.of<TaskData>(context, listen: false).loadTasks(value));
    });
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _menuSlideAnimation =
        Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0))
            .animate(_controller);
    _homeSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.6, 0)).animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    Provider.of<TaskData>(context, listen: false).saveTasks();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: [
          Menu(
              slideAnimation: _menuSlideAnimation,
              menuScaleAnimation: _menuScaleAnimation),
          GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0)
                setState(() {
                  if (isCollapsed) _controller.forward();
                  isCollapsed = false;
                });
              else
                setState(() {
                  if (isCollapsed) _controller.reverse();
                  isCollapsed = true;
                });
            },
            child: SlideTransition(
              position: _homeSlideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Material(
                  borderOnForeground: true,
                  animationDuration: duration,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.all(
                    Radius.circular(isCollapsed ? 0 : 35),
                  ),
                  elevation: 8.0,
                  color: Colors.blueAccent,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50.0, left: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 8.0,
                                  shape: SquircleBorder(
                                      side: BorderSide(
                                          color: Colors.blueAccent, width: 1.0),
                                      superRadius: 5.0),
                                  child: Container(
                                    height: 55.0,
                                    width: 55.0,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (isCollapsed)
                                            _controller.forward();
                                          else
                                            _controller.reverse();
                                          isCollapsed = !isCollapsed;
                                        });
                                      },
                                      child: Icon(Icons.menu,
                                          size: 30.0, color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Todoey',
                                  style: GoogleFonts.merienda(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).canvasColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${Provider.of<TaskData>(context).tasks.length} Tasks',
                                  style: GoogleFonts.merienda(
                                      fontSize: 16.0,
                                      color: Theme.of(context).canvasColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                                color: Theme.of(context).canvasColor,
                              ),
                              child: TasksList(),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 18.0,
                        right: 18.0,
                        child: FloatingActionButton(
                          shape: SquircleBorder(superRadius: 5.0),
                          tooltip: 'Add new task',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => AddTask(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0)),
                                ),
                                isScrollControlled: true);
                          },
                          backgroundColor: Colors.blueAccent,
                          splashColor: Colors.blue,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
