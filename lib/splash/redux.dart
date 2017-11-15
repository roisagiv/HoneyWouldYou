import 'dart:async';

import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

///
class SplashReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, @checked Action<dynamic, dynamic> action) {
    if (action is OnNoAuthenticationAction) {
      return state.rebuild((AppStateBuilder b) => b
        ..authentication.authenticationStatus =
            AuthenticationStatus.notAuthenticated);
    }
    return state;
  }
}

///
class SplashEpic extends EpicClass<AppState> {
  final Authenticator _authenticator;

  ///
  SplashEpic(this._authenticator);

  ///
  @override
  Stream<dynamic> call(
          @checked Stream<dynamic> actions, EpicStore<AppState> store) =>
      actions
          .where(
              (Action<dynamic, dynamic> action) => action is OnSplashInitAction)
          .asyncMap((Action<dynamic, dynamic> action) =>
              _authenticator.currentUser().then((AuthenticatedUser user) async {
                if (user != null) {
                  return new OnUserAuthenticationSucceedAction(user);
                }
                return new OnNoAuthenticationAction();
              }));
}

///
class OnSplashInitAction extends Action<Null, Null> {}

///
class OnNoAuthenticationAction extends Action<Null, Null> {}
