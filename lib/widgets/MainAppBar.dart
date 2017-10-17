import 'package:flutter/material.dart';
import 'package:honeywouldyou/widgets/BottomAppBar.dart';

class MainAppBar extends AppBar {
  MainAppBar(TextStyle titleTextStyle)
      : super(
          title: new Text(
            "Today",
            style: titleTextStyle,
          ),
          bottom: new BottomAppBar(),
        );
}