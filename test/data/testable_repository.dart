import 'dart:async';
import 'dart:io';

import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/services.dart';

///
class TestableRepository extends LocalFileRepository {
  ///
  ListModel lastAddedTask;

  ///
  String lastRemovedListId;

  ///
  @override
  Future<String> loadJson() =>
      new File('./assets/mock/lists.json').readAsString();

  ///
  @override
  Future<Null> add(ListModel list, String userId) {
    lastAddedTask = list;
    return super.add(list, userId);
  }

  @override
  Future<Null> remove(String listId) {
    lastRemovedListId = listId;
    return super.remove(listId);
  }
}
