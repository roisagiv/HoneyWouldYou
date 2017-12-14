import 'dart:async';
import 'dart:collection';

import 'package:async/src/result.dart';
import 'package:honeywouldyou/auth/authenticator.dart';

///
class TestableAuthenticator implements Authenticator {
  ///
  Queue<Result<AuthenticatedUser>> users =
      new Queue<Result<AuthenticatedUser>>();

  ///
  TestableAuthenticator();

  ///
  factory TestableAuthenticator.configured() {
    final TestableAuthenticatedUser user = new TestableAuthenticatedUser(
        id: '123',
        email: 'email@email.com',
        displayName: 'name',
        photoUrl: 'photo');

    final TestableAuthenticator authenticator = new TestableAuthenticator();
    authenticator.users.add(new Result<AuthenticatedUser>.value(user));
    return authenticator;
  }

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

  ///
  @override
  Future<Result<AuthenticatedUser>> signInWithGoogle(
          {String accessToken, String idToken}) =>
      new Future<Result<AuthenticatedUser>>.delayed(
          new Duration(milliseconds: 10), () => users.removeFirst());
}

///
class TestableAuthenticatedUser implements AuthenticatedUser {
  @override
  String displayName;

  @override
  String email;

  @override
  String photoUrl;

  @override
  String id;

  ///
  TestableAuthenticatedUser(
      {this.displayName, this.email, this.photoUrl, this.id});
}
