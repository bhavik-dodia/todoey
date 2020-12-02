import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetails extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final Function onDelete;
  final Function onEdit;
  final Function onBack;

  TaskDetails(
      {this.title,
      this.description,
      this.time,
      this.onDelete,
      this.onEdit,
      this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0, left: 30.0, bottom: 20.0),
            child: Card(
              elevation: 8.0,
              shape: SquircleBorder(),
              color: Theme.of(context).canvasColor,
              child: Container(
                height: 55.0,
                width: 55.0,
                child: IconButton(
                  tooltip: 'Return to Home',
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: onBack,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Theme.of(context).canvasColor,
              ),
              child: ListView(
                padding: EdgeInsets.all(15.0),
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merienda(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.merienda(fontSize: 18),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          time,
                          style: GoogleFonts.merienda(fontSize: 12),
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
                              tooltip: 'Edit Task',
                              icon: FaIcon(FontAwesomeIcons.solidEdit,
                                  color: Theme.of(context).accentColor),
                              highlightColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              splashColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.5),
                              onPressed: onEdit),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 0.0,
                          clipBehavior: Clip.antiAlias,
                          shape: SquircleBorder(),
                          color: Colors.redAccent.withOpacity(0.3),
                          child: IconButton(
                              tooltip: 'Delete Task',
                              icon: Icon(Icons.delete_forever_rounded,
                                  color: Colors.redAccent),
                              iconSize: 30.0,
                              highlightColor: Colors.redAccent.withOpacity(0.4),
                              splashColor: Colors.redAccent.withOpacity(0.5),
                              onPressed: onDelete),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'images/todolist.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
