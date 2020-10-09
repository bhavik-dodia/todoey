import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  MenuTile({this.title, this.icon, this.isSelected, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isSelected ? Theme.of(context).accentColor.withOpacity(0.3) : null,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        onTap: onTap,
        selected: isSelected,
        leading: FaIcon(
          icon,
          color: isSelected ? Theme.of(context).accentColor : null,
        ),
        title: Text(
          title,
          style: GoogleFonts.merienda(
            fontSize: 18.0,
            fontWeight: isSelected ? FontWeight.bold : null,
            color: isSelected ? Theme.of(context).accentColor : null,
          ),
        ),
      ),
    );
  }
}
