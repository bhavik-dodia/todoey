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
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: 50.0,
            bottom: 15.0,
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
                    child: Image.asset(
                      'images/appicon.png',
                      scale: 6,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Todoey',
                        style: GoogleFonts.merienda(
                            fontSize: 25.0,
                            color: Theme.of(context).accentColor),
                      ),
                      subtitle: Text(
                        '2.6.0',
                        style: GoogleFonts.merienda(fontSize: 12.0),
                      ),
                    ),
                  ),
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
                          style: GoogleFonts.merienda(color: Colors.grey[600]),
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
                                splashColor: Colors.blueAccent.withOpacity(0.5),
                                onPressed: () async => await launch(
                                    'https://www.linkedin.com/in/bhavikdodia2000/'),
                              ),
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
                                    'https://github.com/bhavik-dodia'),
                              ),
                            ),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.pinkAccent.withOpacity(0.3),
                              child: IconButton(
                                tooltip: 'Gmail',
                                icon:
                                    Icon(Icons.mail, color: Colors.pinkAccent),
                                highlightColor:
                                    Colors.pinkAccent.withOpacity(0.4),
                                splashColor: Colors.pinkAccent.withOpacity(0.5),
                                onPressed: () async => await launch(
                                    'mailto:dodiabhavik.db@gmail.com'),
                              ),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        ),
                        Divider(indent: 10.0, endIndent: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Special Thanks',
                              style: GoogleFonts.merienda(
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Card(
                            elevation: 2.0,
                            clipBehavior: Clip.antiAlias,
                            shape: SquircleBorder(),
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.center,
                                widthFactor: 0.87,
                                heightFactor: 0.87,
                                child: Image.asset(
                                  'images/profile_pic.png',
                                  scale: 6.7,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            'Deep Gandhi',
                            style: GoogleFonts.merienda(
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            'Designing is all about viewing the world from a different point of view, It\'s a way of looking anew, as if you have never seen it before the first time.',
                            style: GoogleFonts.merienda(),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 10.0),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.deepOrangeAccent.withOpacity(0.3),
                              child: IconButton(
                                tooltip: 'Behance',
                                icon: FaIcon(
                                  FontAwesomeIcons.behance,
                                  color: Colors.deepOrangeAccent,
                                ),
                                highlightColor:
                                    Colors.deepOrangeAccent.withOpacity(0.4),
                                splashColor:
                                    Colors.deepOrangeAccent.withOpacity(0.5),
                                onPressed: () async => await launch(
                                    'https://www.behance.net/hiteshgandhi'),
                              ),
                            ),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.greenAccent.withOpacity(0.3),
                              child: IconButton(
                                tooltip: 'Linked In',
                                icon: FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.greenAccent,
                                ),
                                highlightColor:
                                    Colors.greenAccent.withOpacity(0.4),
                                splashColor:
                                    Colors.greenAccent.withOpacity(0.5),
                                onPressed: () async => await launch(
                                    'https://www.linkedin.com/in/deep-gandhi-b37572170/'),
                              ),
                            ),
                            Card(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAlias,
                              shape: SquircleBorder(),
                              color: Colors.deepPurpleAccent.withOpacity(0.3),
                              child: IconButton(
                                tooltip: 'Instagram',
                                icon: FaIcon(FontAwesomeIcons.instagram,
                                    color: Colors.deepPurpleAccent),
                                highlightColor:
                                    Colors.deepPurpleAccent.withOpacity(0.4),
                                splashColor:
                                    Colors.deepPurpleAccent.withOpacity(0.5),
                                onPressed: () async => await launch(
                                    'https://www.instagram.com/magicman_deep/'),
                              ),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        ),
                        SizedBox(height: 10.0),
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
