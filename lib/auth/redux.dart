import 'dart:async';

import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

///
class AuthReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, @checked Action<dynamic, dynamic> action) {
    switch (action.runtimeType) {
      case OnUserAuthenticationSucceedAction:
        return _onUserAuthenticated(state, action);

      case OnUserAuthenticationFailedAction:
        return _onUserAuthenticationFailed(state, action);

      case OnLoginButtonClickedAction:
      case OnSignUpButtonClickedAction:
        return state.rebuild((AppStateBuilder b) => b
          ..authentication.authenticationStatus =
              AuthenticationStatus.inProgress
          ..authentication.errorMessage = null);

      case OnSignOutButtonClickedAction:
        return state.rebuild((AppStateBuilder b) => b
          ..authentication.authenticationStatus =
              AuthenticationStatus.notAuthenticated
          ..authentication.currentUser = null);
    }
    return state;
  }

  AppState _onUserAuthenticated(
          AppState state, OnUserAuthenticationSucceedAction action) =>
      state.rebuild((AppStateBuilder b) => b
        ..authentication.currentUser = new UserModel((UserModelBuilder b) => b
          ..email = action.payload.email
          ..displayName = action.payload.displayName).toBuilder()
        ..authentication.authenticationStatus =
            AuthenticationStatus.authenticated);

  AppState _onUserAuthenticationFailed(
          AppState state, OnUserAuthenticationFailedAction action) =>
      state.rebuild((AppStateBuilder b) => b
        ..authentication.authenticationStatus = AuthenticationStatus.error
        ..authentication.currentUser = null
        ..authentication.errorMessage = action.payload);
}

/**
 * Epics
 */

///
class SignOutEpic extends EpicClass<AppState> {
  final Authenticator _authenticator;

  ///
  SignOutEpic(this._authenticator);

  @override
  Stream<dynamic> call(
          @checked Stream<dynamic> actions, EpicStore<AppState> store) =>
      actions
          .where((Action<dynamic, dynamic> action) =>
              action is OnSignOutButtonClickedAction)
          .asyncMap((Action<dynamic, dynamic> action) => _authenticator
              .signOut()
              .whenComplete(() => new OnSignOutCompletedAction()));
}
/*
Actions
*/

///
class OnUserAuthenticationSucceedAction
    extends Action<AuthenticatedUser, Null> {
  ///
  OnUserAuthenticationSucceedAction(AuthenticatedUser user)
      : super(payload: user);
}

///
class OnUserAuthenticationFailedAction extends Action<String, Null> {
  ///
  OnUserAuthenticationFailedAction(String error) : super(payload: error);
}

///
class OnSignUpButtonClickedAction
    extends Action<_OnButtonClickedActionData, Null> {
  ///
  final String email;

  ///
  final String password;

  ///
  OnSignUpButtonClickedAction({this.email, this.password})
      : super(
            payload: new _OnButtonClickedActionData(
                password: password, email: email));
}

///
class OnLoginButtonClickedAction
    extends Action<_OnButtonClickedActionData, Null> {
  ///
  final String email;

  ///
  final String password;

  ///
  OnLoginButtonClickedAction({this.email, this.password})
      : super(
            payload: new _OnButtonClickedActionData(
                password: password, email: email));
}

///
class _OnButtonClickedActionData {
  ///
  final String email;

  ///
  final String password;

  _OnButtonClickedActionData({this.email, this.password});
}

///
class OnSignOutButtonClickedAction extends Action<Null, Null> {}

///
class OnSignOutCompletedAction extends Action<Null, Null> {}
