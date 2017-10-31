import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/navigation.dart';

///
class Injector {
  static final Injector _singleton = new Injector._internal();

  ///
  factory Injector() => _singleton;

  Injector._internal();

  ///
  ListRepository get listRepository => new ListRepository();

  ///
  Navigation get navigation => new Navigation();
}
