import 'package:flutter/material.dart';
import 'package:honeywouldyou/widgets/MainAppBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MainAppBar(Theme.of(context).textTheme.display1),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: new Text("$index"),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
