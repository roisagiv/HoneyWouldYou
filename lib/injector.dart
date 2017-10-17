import 'package:honeywouldyou/data/list_repository.dart';

///
class Injector {
  static final Injector _singleton = new Injector._internal();

  ///
  factory Injector() => _singleton;

  Injector._internal();

  ///
  ListRepository get listRepository => new ListRepository();
}
