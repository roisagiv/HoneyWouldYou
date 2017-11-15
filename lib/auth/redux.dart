import 'dart:async';

import 'package:async/async.dart';
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
          ..uid = action.payload.id
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
class SignUpEpic extends EpicClass<AppState> {
  final Authenticator _authenticator;

  ///
  SignUpEpic(this._authenticator);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) =>
      actions
          .where((Action<dynamic, dynamic> action) =>
              action is OnSignUpButtonClickedAction)
          .asyncMap((OnSignUpButtonClickedAction action) => _authenticator
                  .createUserWithEmailAndPassword(
                      email: action.email, password: action.password)
                  .then((Result<AuthenticatedUser> result) {
                if (result.isError) {
                  return new OnUserAuthenticationFailedAction(
                      result.asError.error);
                } else {
                  return new OnUserAuthenticationSucceedAction(
                      result.asValue.value);
                }
              }));
}

///
class SignInEpic extends EpicClass<AppState> {
  final Authenticator _authenticator;

  ///
  SignInEpic(this._authenticator);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) =>
      actions
          .where((Action<dynamic, dynamic> action) =>
              action is OnLoginButtonClickedAction)
          .asyncMap((OnLoginButtonClickedAction action) => _authenticator
                  .signInWithEmailAndPassword(
                      email: action.email, password: action.password)
                  .then((Result<AuthenticatedUser> result) {
                if (result.isError) {
                  return new OnUserAuthenticationFailedAction(
                      result.asError.error);
                } else {
                  return new OnUserAuthenticationSucceedAction(
                      result.asValue.value);
                }
              }));
}

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

///
Epic<AppState> rootAuthEpic(Authenticator authenticator) =>
    combineEpics(<Epic<AppState>>[
      new SignUpEpic(authenticator),
      new SignInEpic(authenticator),
      new SignOutEpic(authenticator)
    ]);

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
