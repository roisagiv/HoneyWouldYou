import 'package:flutter/material.dart';
import 'package:honeywouldyou/theme.dart';

///
class BottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  ///
  final Widget subtitle;

  ///
  const BottomAppBar({this.subtitle}) : super();

  ///
  @override
  Widget build(BuildContext context) => new Expanded(
          child: new Padding(
        padding: const EdgeInsets.all(AppDimens.subtitlePadding),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle,
          ],
        ),
      ));

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.subtitleHeight);
}
