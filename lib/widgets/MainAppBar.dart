import 'package:flutter/material.dart';
import 'package:honeywouldyou/widgets/BottomAppBar.dart';

/// MainAppBar
class MainAppBar extends AppBar {
  ///
  MainAppBar(final TextStyle titleTextStyle)
      : super(
          title: new Text(
            'Today',
            style: titleTextStyle,
          ),
          bottom: new BottomAppBar(),
        );
}
