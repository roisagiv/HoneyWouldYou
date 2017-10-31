import 'package:flutter/material.dart';
import 'package:honeywouldyou/widgets/bottom_app_bar.dart';

/// MainAppBar
class MainAppBar extends AppBar {
  ///
  MainAppBar({final Widget leading, final Widget title, final Widget subtitle})
      : super(
            title: title,
            bottom: new BottomAppBar(
              subtitle: subtitle,
            ),
            leading: leading);
}
