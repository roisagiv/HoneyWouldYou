import 'dart:async';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/services.dart';

///
class TestableRepository extends LocalFileRepository {
  ///
  ListModel lastAddedList;

  ///
  TaskModel lastAddedTask;

  ///
  String lastRemovedListId;

  ///
  @override
  Future<String> loadJson() =>
      new File('./assets/mock/lists.json').readAsString();

  ///
  @override
  Future<Null> addList(ListModel list, String userId) {
    lastAddedList = list;
    return super.addList(list, userId);
  }

  @override
  Future<Null> removeList(String listId) {
    lastRemovedListId = listId;
    return super.removeList(listId);
  }

  @override
  Future<Null> addTask(String name, String listId) {
    lastAddedTask = new TaskModel.fromMap(<String, dynamic>{
      'name': name,
      '_id': faker.guid.guid(),
      'completed': false
    }, listId);
    return super.addTask(name, listId);
  }
}
