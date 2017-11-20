import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:honeywouldyou/data/models.dart';

///
abstract class Repository {
  ///
  Stream<Iterable<ListModel>> lists(String userId);

  ///
  Future<Null> add(ListModel list, String userId);

  ///
  Future<Null> remove(String listId);

  ///
  Stream<Iterable<TaskModel>> tasks({String userId, String listId});
}

///
class LocalFileRepository implements Repository {
  Map<String, ListModel> _lists = <String, ListModel>{};

  final StreamController<Iterable<ListModel>> _streamController =
      new StreamController<Iterable<ListModel>>();

  final StreamController<Iterable<TaskModel>> _tasksController =
      new StreamController<Iterable<TaskModel>>();

  ///
  Future<Null> init() async => loadJson()
          .then((String json) => JSON.decode(json))
          .then((Map<String, dynamic> map) => map['lists']
              .map((Map<String, dynamic> item) => new ListModel.fromMap(item)))
          .then((Iterable<ListModel> lists) {
        _lists = new Map<String, ListModel>.fromIterable(lists,
            key: (ListModel l) => l.id);
        return new Future<Null>.value(null);
      });

  ///
  Future<String> loadJson() => rootBundle.loadString('assets/mock/lists.json');

  @override
  Stream<Iterable<ListModel>> lists(String userId) {
    new Future<void>.delayed(new Duration(milliseconds: 1),
        () => _streamController.add(_lists.values));
    return _streamController.stream;
  }

  ///
  @override
  Stream<Iterable<TaskModel>> tasks({String userId, String listId}) {
    new Future<void>.delayed(new Duration(milliseconds: 1),
        () => _tasksController.add(_lists[listId].tasks.values));
    return _tasksController.stream;
  }

  @override
  Future<Null> add(ListModel list, String userId) {
    _lists[list.id] = list;
    return new Future<Null>.delayed(new Duration(milliseconds: 1), () {
      _streamController.add(_lists.values);
    });
  }

  @override
  Future<Null> remove(String listId) => new Future<Null>(() {
        _lists.remove(listId);
        _streamController.add(_lists.values);
      });
}

///
class FirestoreRepository implements Repository {
  final Firestore _firestore;

  ///
  const FirestoreRepository(this._firestore);

  ///
  @override
  Stream<Iterable<ListModel>> lists(String userId) => _firestore
      .collection('lists')
      .where('owner', isEqualTo: userId)
      .snapshots
      .asyncMap((QuerySnapshot q) => q.documents)
      .map((List<DocumentSnapshot> ds) => ds.map(_listFromMap));

  ///
  @override
  Stream<Iterable<TaskModel>> tasks({String userId, String listId}) =>
      _firestore
          .collection('lists/$listId/tasks')
          .snapshots
          .asyncMap((QuerySnapshot q) => q.documents)
          .map((Iterable<DocumentSnapshot> d) =>
              d.map((DocumentSnapshot d) => _taskFromMap(d, listId)));

  ///
  TaskModel _taskFromMap(DocumentSnapshot d, String listId) =>
      new TaskModel((TaskModelBuilder b) => b
        ..id = d.documentID
        ..name = d['name']
        ..listId = listId
        ..completed = d['completed']
        ..build());

  @override
  Future<Null> add(ListModel list, String userId) => _firestore
      .collection('lists')
      .document()
      .setData(_listToMap(list: list, owner: userId));

  ///
  @override
  Future<Null> remove(String listId) =>
      _firestore.collection('lists').document(listId).delete();

  ///
  Map<String, dynamic> _listToMap({ListModel list, String owner}) =>
      <String, dynamic>{'name': list.name, 'owner': owner};

  ///
  ListModel _listFromMap(DocumentSnapshot document) =>
      new ListModel((ListModelBuilder b) => b
        ..name = document['name']
        ..id = document.documentID
        ..tasks = new MapBuilder<String, TaskModel>()
        ..build());
}
