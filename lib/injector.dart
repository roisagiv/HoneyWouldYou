import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:honeywouldyou/services.dart';

///
class Injector {
  static final Injector _singleton = new Injector._internal();

  ///
  factory Injector() => _singleton;

  Injector._internal();

  ///
  Navigation get navigation => new Navigation();

  ///
  Authenticator get authenticator =>
      new FirebaseAuthenticator(FirebaseAuth.instance);

  ///
  Repository get repository => new FirestoreRepository(Firestore.instance);
}
