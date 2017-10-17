import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          new DateFormat("EEE, MMM d, ''yy").format(new DateTime.now()),
        )
      ],
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(20.0);
}
