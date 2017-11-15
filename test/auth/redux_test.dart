import 'dart:async';

import 'package:async/async.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../data/testable_repository.dart';
import 'testable_authenticator.dart';

void main() {
  group('auth', () {
    ///
    Store<AppState> store;
    TestableAuthenticator authenticator;

    ///
    setUp(() async {
      authenticator = new TestableAuthenticator();
      store = createStore(
          repository: new TestableRepository(),
          authenticator: authenticator,
          logging: true);
    });

    test('SignIn - OnUserAuthenticationSucceedAction', () async {
      final String email = faker.internet.email();
      final String password = faker.internet.password();
      expect(store.state.authentication.currentUser, isNull);

      authenticator.users.add(new Result<AuthenticatedUser>.value(
          new TestableAuthenticatedUser(email: email)));

      store.dispatch(
          new OnLoginButtonClickedAction(email: email, password: password));

      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.inProgress);

      await new Future<Null>.delayed(new Duration(milliseconds: 200));

      expect(store.state.authentication.currentUser, isNotNull);
      expect(store.state.authentication.currentUser.email, email);
      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.authenticated);
    });

    test('SignUp - OnUserAuthenticationSucceedAction', () async {
      final String email = faker.internet.email();
      final String password = faker.internet.password();
      expect(store.state.authentication.currentUser, isNull);

      authenticator.users.add(new Result<AuthenticatedUser>.value(
          new TestableAuthenticatedUser(email: email)));

      store.dispatch(
          new OnSignUpButtonClickedAction(email: email, password: password));

      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.inProgress);

      await new Future<Null>.delayed(new Duration(milliseconds: 200));

      expect(store.state.authentication.currentUser, isNotNull);
      expect(store.state.authentication.currentUser.email, email);
      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.authenticated);
    });

    test('SignUp - OnUserAuthenticationFailedAction', () async {
      final String email = faker.internet.email();
      final String password = faker.internet.password();
      final String error = faker.randomGenerator.string(10);
      expect(store.state.authentication.currentUser, isNull);

      final String exception =
          new PlatformException(code: 'code', details: error).details;
      authenticator.users.add(new Result<AuthenticatedUser>.error(exception));

      store.dispatch(
          new OnSignUpButtonClickedAction(email: email, password: password));

      await new Future<Null>.delayed(new Duration(milliseconds: 200));

      expect(store.state.authentication.currentUser, isNull);
      expect(store.state.authentication.authenticationStatus,
          AuthenticationStatus.error);
      expect(store.state.authentication.errorMessage, error);
    });
  });
}
