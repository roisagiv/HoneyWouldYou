import 'dart:async';
import 'dart:io';

import 'package:honeywouldyou/data/list_repository.dart';

///
class TestableListRepository extends ListRepository {
  @override
  Future<String> loadJson() =>
      new File('./assets/mock/lists.json').readAsString();
}
