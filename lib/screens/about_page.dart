import 'package:Todoey/models/squircle_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).canvasColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.2,
            0.5,
          ],
        ),
      ),
      child: ListView(
        // shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: 50.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 15.0,
            right: 15.0),
        children: [
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 100.0,
                      width: 100.0,
                      child: Image.asset('images/app_icon.png')),
                  Expanded(
                      child: ListTile(
                    title: Text(
                      'Todoey',
                      style: GoogleFonts.merienda(
                          fontSize: 25.0, color: Theme.of(context).accentColor),
                    ),
                    subtitle: Text(
                      '2.0.0',
                      style: GoogleFonts.merienda(fontSize: 12.0),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 45.0),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        SizedBox(height: 60.0),
                        Text(
                          'Designed and Developed By',
                          style: GoogleFonts.merienda(color: Colors.grey),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Bhavik Dodia',
                          style: GoogleFonts.merienda(
                              fontSize: 30.0,
                              color: Theme.of(context).accentColor),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 10.0),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.blueAccent.withOpacity(0.3),
                              child: IconButton(
                                  tooltip: 'Linked In',
                                  icon: FaIcon(
                                    FontAwesomeIcons.linkedin,
                                    color: Colors.blueAccent,
                                  ),
                                  highlightColor:
                                      Colors.blueAccent.withOpacity(0.4),
                                  splashColor:
                                      Colors.blueAccent.withOpacity(0.5),
                                  onPressed: () async => await launch(
                                      'https://www.linkedin.com/in/bhavikdodia2000/')),
                            ),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.purpleAccent.withOpacity(0.3),
                              child: IconButton(
                                  tooltip: 'GitHub',
                                  icon: FaIcon(
                                    FontAwesomeIcons.github,
                                    color: Colors.purpleAccent,
                                  ),
                                  highlightColor:
                                      Colors.purpleAccent.withOpacity(0.4),
                                  splashColor:
                                      Colors.purpleAccent.withOpacity(0.5),
                                  onPressed: () async => await launch(
                                      'https://github.com/bhavik-dodia')),
                            ),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.pinkAccent.withOpacity(0.3),
                              child: IconButton(
                                  tooltip: 'Gmail',
                                  icon: Icon(Icons.mail,
                                      color: Colors.pinkAccent),
                                  highlightColor:
                                      Colors.pinkAccent.withOpacity(0.4),
                                  splashColor:
                                      Colors.pinkAccent.withOpacity(0.5),
                                  onPressed: () async => await launch(
                                        'mailto:dodiabhavik.db@gmail.com',
                                      )),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        // Divider(),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 8.0,
                  clipBehavior: Clip.antiAlias,
                  shape: SquircleBorder(),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: 0.87,
                      heightFactor: 0.87,
                      child: Image.asset(
                        'images/male_avatar_blueAccent.png',
                        scale: 6.7,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Text(
                    'Support',
                    style: GoogleFonts.merienda(
                        fontSize: 18.0, color: Theme.of(context).accentColor),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Donate',
                    style: GoogleFonts.merienda(),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Provide feedback',
                    style: GoogleFonts.merienda(),
                  ),
                  onTap: () async => await launch(
                    'mailto:dodiabhavik.db@gmail.com',
                  ),
                ),
                ListTile(
                  title: Text(
                    'Rate on play store',
                    style: GoogleFonts.merienda(),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Open source licences',
                    style: GoogleFonts.merienda(),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
