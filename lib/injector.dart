import 'package:firebase_auth/firebase_auth.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/navigation.dart';

///
class Injector {
  static final Injector _singleton = new Injector._internal();

  ///
  factory Injector() => _singleton;

  Injector._internal();

  ///
  ListRepository get listRepository => const ListRepository();

  ///
  Navigation get navigation => new Navigation();

  ///
  Authenticator get authenticator =>
      new FirebaseAuthenticator(FirebaseAuth.instance);
}
