import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../data/testable_list_repository.dart';

void main() {
  group('auth', () {
    ///
    Store<AppState> store;
    _TestableAuthenticator authenticator;

    ///
    setUp(() async {
      authenticator = new _TestableAuthenticator();
      store = createStore(
          listRepository: new TestableListRepository(),
          authenticator: authenticator,
          logging: true)
        ..dispatch(new OnHomePageConnectedAction());

      await new Future<Null>.delayed(new Duration(milliseconds: 50));
    });

    test('OnUserAuthenticationSucceedAction', () async {
      final String email = faker.internet.email();
      final String password = faker.internet.password();
      expect(store.state.authentication.currentUser, isNull);

      authenticator.users.add(new Result<AuthenticatedUser>.value(
          new _TestableAuthenticatedUser(email: email)));

      store.dispatch(
          new OnSignUpButtonClickedAction(email: email, password: password));

      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.inProgress);

      await new Future<Null>.delayed(new Duration(milliseconds: 100));

      expect(store.state.authentication.currentUser, isNotNull);
      expect(store.state.authentication.currentUser.email, email);
      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.authenticated);
    });

    test('OnUserAuthenticationFailedAction', () async {
      final String email = faker.internet.email();
      final String password = faker.internet.password();
      final String error = faker.randomGenerator.string(10);
      expect(store.state.authentication.currentUser, isNull);

      final String exception =
          new PlatformException(code: 'code', details: error).details;
      authenticator.users.add(new Result<AuthenticatedUser>.error(exception));

      store.dispatch(
          new OnSignUpButtonClickedAction(email: email, password: password));

      await new Future<Null>.delayed(new Duration(milliseconds: 100));

      expect(store.state.authentication.currentUser, isNull);
      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.error);
      expect(store.state.authentication.errorMessage, error);
    });
  });
}

///
class _TestableAuthenticator implements Authenticator {
  ///
  Queue<Result<AuthenticatedUser>> users =
      new Queue<Result<AuthenticatedUser>>();

  @override
  Future<Result<AuthenticatedUser>> createUserWithEmailAndPassword(
          {String email, String password}) =>
      new Future<Result<AuthenticatedUser>>.delayed(
          new Duration(milliseconds: 10), () => users.removeFirst());

  @override
  Future<AuthenticatedUser> currentUser() =>
      new Future<AuthenticatedUser>.delayed(
          new Duration(milliseconds: 10), () => users.first.asFuture);

  @override
  Future<Result<AuthenticatedUser>> signInWithEmailAndPassword(
          {String email, String password}) =>
      new Future<Result<AuthenticatedUser>>.delayed(
          new Duration(milliseconds: 10), () => users.removeFirst());

  @override
  Future<Null> signOut() => null;
}

class _TestableAuthenticatedUser implements AuthenticatedUser {
  @override
  String displayName;

  @override
  String email;

  @override
  String photoUrl;

  _TestableAuthenticatedUser({this.displayName, this.email, this.photoUrl});
}
