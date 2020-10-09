import 'package:Todoey/models/menu_item.dart';
import 'package:Todoey/screens/about_page.dart';
import 'package:Todoey/widgets/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  final Function manageDrawer;
  Menu(
      {Key key,
      @required Animation<Offset> slideAnimation,
      @required Animation<double> menuScaleAnimation,
      this.manageDrawer})
      : _slideAnimation = slideAnimation,
        _menuScaleAnimation = menuScaleAnimation,
        super(key: key);

  final Animation<Offset> _slideAnimation;
  final Animation<double> _menuScaleAnimation;

  List<MenuItem> _menuItems = [
    MenuItem(
      iconData: FontAwesomeIcons.home,
      name: 'Home',
      action: (context) {},
    ),
    MenuItem(
      iconData: FontAwesomeIcons.tools,
      name: 'Settings',
      action: (context) {},
    ),
    MenuItem(
      iconData: FontAwesomeIcons.solidCommentDots,
      name: 'FeedBack',
      action: (context) async => await launch(
        'mailto:dodiabhavik.db@gmail.com',
      ),
    ),
    MenuItem(
      iconData: FontAwesomeIcons.infoCircle,
      name: 'About',
      action: (context) {
        showModalBottomSheet(
          context: context,
          builder: (context) => AboutPage(),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          isScrollControlled: true,
          isDismissible: true,
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 0.5 * MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final menuitem = _menuItems[index];
                return MenuTile(
                  icon: menuitem.iconData,
                  title: menuitem.name,
                  isSelected: index == 0 ? true : false,
                  onTap: () {
                    manageDrawer();
                    menuitem.action(context);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
