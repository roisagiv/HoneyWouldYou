import 'dart:async';

import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

///
abstract class Authenticator {
  ///
  Future<Result<AuthenticatedUser>> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  ///
  Future<Result<AuthenticatedUser>> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  ///
  Future<AuthenticatedUser> currentUser();

  ///
  Future<Null> signOut();
}

///
abstract class AuthenticatedUser {
  /// The name of the user.
  String get displayName;

  /// The URL of the user’s profile photo.
  String get photoUrl;

  /// The user’s email address.
  String get email;

  ///
  String get id;
}

///
class FirebaseAuthenticator implements Authenticator {
  final FirebaseAuth _auth;

  ///
  FirebaseAuthenticator(this._auth);

  ///
  @override
  Future<Result<AuthenticatedUser>> createUserWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return new Result<AuthenticatedUser>.value(
          new FirebaseAuthenticatedUser(user));
    } on PlatformException catch (e) {
      return new Result<AuthenticatedUser>.error(e.details);
    }
  }

  ///
  @override
  Future<Result<AuthenticatedUser>> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return new Result<AuthenticatedUser>.value(
          new FirebaseAuthenticatedUser(user));
    } on PlatformException catch (e) {
      return new Result<AuthenticatedUser>.error(e.details);
    }
  }

  ///
  @override
  Future<AuthenticatedUser> currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      return new FirebaseAuthenticatedUser(user);
    } else {
      return null;
    }
  }

  ///
  @override
  Future<Null> signOut() => _auth.signOut();
}

///
class FirebaseAuthenticatedUser implements AuthenticatedUser {
  final FirebaseUser _firebaseUser;

  ///
  FirebaseAuthenticatedUser(this._firebaseUser);

  @override
  String get displayName => _firebaseUser.displayName;

  @override
  String get email => _firebaseUser.email;

  @override
  String get photoUrl => _firebaseUser.photoUrl;

  @override
  String get id => _firebaseUser.uid;
}
