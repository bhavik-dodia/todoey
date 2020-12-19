import 'dart:convert';
import 'dart:io';
import 'package:Todoey/models/app_theme.dart';
import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool isCollapsed = true;
  double screenWidth, screenHeight;

  final Duration duration = const Duration(milliseconds: 300);

  AnimationController _controller;
  AnimationController _fabController;

  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<double> _fabFadeAnimation;
  Animation<Offset> _menuSlideAnimation;
  Animation<Offset> _homeSlideAnimation;

  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((Directory directory) {
      File('${directory.path}/tasks.json').readAsString().then((value) =>
          Provider.of<TaskData>(context, listen: false).loadTasks(value));
      File('${directory.path}/settings.json').readAsString().then((value) {
        var json = jsonDecode(value);
        Provider.of<AppTheme>(context, listen: false).currentIndex =
            json['colorIndex'];
        Provider.of<TaskData>(context, listen: false).deleteOnComplete =
            json['autoDelete'];
      });
    });

    _controller = AnimationController(vsync: this, duration: duration);
    _fabController = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _fabFadeAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _fabController, curve: Curves.easeInBack));
    _menuSlideAnimation =
        Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0))
            .animate(_controller);
    _homeSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.6, 0)).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      Provider.of<TaskData>(context, listen: false).saveTasks();
      getApplicationDocumentsDirectory().then((Directory directory) {
        File('${directory.path}/settings.json').writeAsStringSync(
          '{"colorIndex": ${Provider.of<AppTheme>(context, listen: false).currentIndex}, "autoDelete": ${Provider.of<TaskData>(context, listen: false).deleteOnComplete}}',
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _fabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  manageDrawer() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        overflow: Overflow.clip,
        children: [
          Menu(
            slideAnimation: _menuSlideAnimation,
            menuScaleAnimation: _menuScaleAnimation,
            manageDrawer: manageDrawer,
          ),
          GestureDetector(
            onVerticalDragUpdate: (details) {},
            onHorizontalDragUpdate: (details) {
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
                  color: Theme.of(context).accentColor,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(top: 50.0, left: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 8.0,
                                  color: Theme.of(context).canvasColor,
                                  shape: SquircleBorder(),
                                  child: Container(
                                    height: 55.0,
                                    width: 55.0,
                                    child: InkWell(
                                      onTap: manageDrawer,
                                      child: Center(
                                        child: AnimatedIcon(
                                          icon: AnimatedIcons.menu_arrow,
                                          progress:
                                              Tween<double>(begin: 0, end: 1)
                                                  .animate(_controller),
                                          size: 30.0,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Todoey',
                                  style: GoogleFonts.merienda(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${Provider.of<TaskData>(context).tasks.length} Tasks',
                                  style: GoogleFonts.merienda(
                                    fontSize: 16.0,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                color: Theme.of(context).canvasColor,
                              ),
                              child: TasksList(
                                onBottom: () =>
                                    setState(() => _fabController.forward()),
                                onTop: () =>
                                    setState(() => _fabController.reverse()),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 18.0,
                        right: 18.0,
                        child: ScaleTransition(
                          scale: _fabFadeAnimation,
                          child: FloatingActionButton(
                            shape: SquircleBorder(),
                            tooltip: 'Add New Task',
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => AddTask(),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              isScrollControlled: true,
                            ),
                            backgroundColor: Theme.of(context).accentColor,
                            splashColor: Theme.of(context).accentColor,
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
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
