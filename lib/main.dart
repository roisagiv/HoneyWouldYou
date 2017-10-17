import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/home/home_page.dart';
import 'package:honeywouldyou/injector.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/theme.dart';
import 'package:redux/redux.dart';

void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info.
  enableFlutterDriverExtension();
  final store = createStore(new Injector().listRepository);
  runApp(new MyApp(store));
}

///
class MyApp extends StatelessWidget {
  final Store _store;

  ///
  const MyApp(this._store);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => new StoreProvider(
        store: _store,
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: AppThemes.main(context),
          home: const HomePage(),
        ),
      );
}
