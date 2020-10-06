import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetails extends StatelessWidget {
  final title;
  final description;
  final time;
  final Function onDelete;
  final Function onBack;

  TaskDetails(
      {this.title, this.description, this.time, this.onDelete, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.blueAccent,
                    ),
                    iconSize: 30.0,
                    onPressed: onBack),
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
                        fontSize: 25, color: Colors.blueAccent),
                  ),
                  Text(
                    description != null ? description : ' ',
                    style: GoogleFonts.merienda(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time != null ? time : ' ',
                        style: GoogleFonts.merienda(fontSize: 13),
                      ),
                      Card(
                        elevation: 0.0,
                        clipBehavior: Clip.antiAlias,
                        shape: SquircleBorder(),
                        color: Colors.redAccent.withOpacity(0.3),
                        child: IconButton(
                            tooltip: 'Delete Task',
                            icon: Icon(Icons.delete_forever,
                                color: Colors.redAccent),
                            iconSize: 30.0,
                            highlightColor: Colors.redAccent.withOpacity(0.4),
                            splashColor: Colors.redAccent.withOpacity(0.5),
                            onPressed: onDelete),
                      ),
                    ],
                  ),
                  Image.asset('images/todolist.png'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
