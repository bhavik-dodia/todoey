import 'package:Todoey/screens/about_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatelessWidget {
  final Function manageDrawer;
  const Menu(
      {Key key,
      @required Animation<Offset> slideAnimation,
      @required Animation<double> menuScaleAnimation,
      this.manageDrawer})
      : _slideAnimation = slideAnimation,
        _menuScaleAnimation = menuScaleAnimation,
        super(key: key);

  final Animation<Offset> _slideAnimation;
  final Animation<double> _menuScaleAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 0.5 * MediaQuery.of(context).size.width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                  onTap: manageDrawer,
                  leading: FaIcon(
                    FontAwesomeIcons.home,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    'Home',
                    style: GoogleFonts.merienda(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.listAlt),
                title: Text(
                  'Tasks',
                  style: GoogleFonts.merienda(fontSize: 18.0),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.tools),
                title: Text(
                  'Settings',
                  style: GoogleFonts.merienda(fontSize: 18.0),
                ),
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.infoCircle),
                  title: Text(
                    'About',
                    style: GoogleFonts.merienda(fontSize: 18.0),
                  ),
                  onTap: () {
                    manageDrawer();
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => AboutPage(),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)),
                        ),
                        isScrollControlled: true,
                        isDismissible: true);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
