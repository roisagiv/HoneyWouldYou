import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/navigation.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/widgets/main_app_bar.dart';
import 'package:redux/redux.dart';

///
class SplashPage extends StatefulWidget {
  final Navigation _navigation;
  final Store<AppState> _store;
  final Authenticator _authenticator;

  ///
  const SplashPage(this._navigation, this._store, this._authenticator);

  @override
  State<StatefulWidget> createState() =>
      new _SplashPageState(_navigation, _store, _authenticator);
}

///
class _SplashPageState extends State<SplashPage> {
  final Navigation _navigation;
  final Store<AppState> _store;
  final Authenticator _authenticator;

  ///
  _SplashPageState(this._navigation, this._store, this._authenticator);

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, AuthenticationStatus>(
        converter: (Store<AppState> store) =>
            store.state.authentication.authenticationStatus,
        builder: (BuildContext context, AuthenticationStatus state) =>
            new Scaffold(
              appBar: new MainAppBar(),
              body: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const CircularProgressIndicator(
                        strokeWidth: 1.0,
                      )
                    ],
                  )
                ],
              ),
            ),
      );

  @override
  void initState() {
    super.initState();
    _initStore();
  }

  Future<Null> _initStore() async {
//    _store.dispatch(new OnSplashInitAction());
    final AuthenticatedUser user = await _authenticator.currentUser();
    if (user == null) {
      _store.dispatch(new OnNoAuthenticationAction());
    } else {
      _store.dispatch(new OnUserAuthenticationSucceedAction(user));
    }

    _navigation.navigateTo(context, '/');
    return new Future<Null>.value(null);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
