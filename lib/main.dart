import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/injector.dart';
import 'package:honeywouldyou/navigation.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/splash/splash_page.dart';
import 'package:honeywouldyou/theme.dart';
import 'package:redux/redux.dart';

void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info.
  enableFlutterDriverExtension();

  final Injector injector = new Injector();
  final Authenticator authenticator = injector.authenticator;

  final Store<AppState> store = createStore(
      listRepository: injector.listRepository,
      authenticator: authenticator,
      logging: true);
  final Navigation navigation = injector.navigation..configure(store: store);
  runApp(new MyApp(store, navigation, authenticator));
}

///
class MyApp extends StatelessWidget {
  final Store<AppState> _store;
  final Navigation _navigation;
  final Authenticator _authenticator;

  ///
  const MyApp(this._store, this._navigation, this._authenticator);

  @override
  // ignore: always_specify_types
  Widget build(BuildContext context) => new StoreProvider(
        store: _store,
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: AppThemes.main(context),
          home: new SplashPage(_navigation, _store, _authenticator),
        ),
      );
}
