import 'dart:async';
import 'dart:io';

import 'package:honeywouldyou/services.dart';

///
class TestableRepository extends LocalFileRepository {
  @override
  Future<String> loadJson() =>
      new File('./assets/mock/lists.json').readAsString();
}
