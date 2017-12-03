import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

///
abstract class Repository {
  ///
  Stream<Iterable<ListModel>> lists(String userId);

  ///
  Observable<Iterable<TaskModel>> tasks({final String listId});

  ///
  Future<Null> addList(ListModel list, String userId);

  ///
  Future<Null> removeList(String listId);

  ///
  Future<Null> addTask(String name, String listId);

  ///
  Future<Null> removeTask(String taskId, String listId);
}

///
class LocalFileRepository implements Repository {
  Map<String, ListModel> _lists = <String, ListModel>{};
  final List<TaskModel> _tasks = <TaskModel>[];

  final StreamController<Iterable<ListModel>> _streamController =
      new StreamController<Iterable<ListModel>>();

  final StreamController<Iterable<TaskModel>> _tasksController =
      new StreamController<Iterable<TaskModel>>();

  ///
  Future<Null> init() async => loadJson()
          .then((String json) => JSON.decode(json))
          .then((Map<String, dynamic> map) =>
              map['lists'].map((Map<String, dynamic> item) {
                _tasks.addAll(item['tasks'].map(
                    (Map<String, dynamic> taskMap) =>
                        new TaskModel.fromMap(taskMap, item['_id'])));
                return new ListModel.fromMap(item);
              }))
          .then((Iterable<ListModel> lists) {
        _lists = new Map<String, ListModel>.fromIterable(lists,
            key: (ListModel l) => l.id);
        return new Future<Null>.value(null);
      });

  ///
  Future<String> loadJson() => rootBundle.loadString('assets/mock/lists.json');

  ///
  @override
  Stream<Iterable<ListModel>> lists(String userId) {
    new Future<void>.delayed(new Duration(milliseconds: 1),
        () => _streamController.add(_lists.values));
    return _streamController.stream;
  }

  ///
  @override
  Future<Null> addList(ListModel list, String userId) {
    _lists[list.id] = list;
    return new Future<Null>.delayed(new Duration(milliseconds: 1), () {
      _streamController.add(_lists.values);
    });
  }

  @override
  Future<Null> removeList(String listId) => new Future<Null>(() {
        _lists.remove(listId);
        _streamController.add(_lists.values);
      });

  @override
  Observable<Iterable<TaskModel>> tasks({String listId}) {
    new Future<void>.delayed(new Duration(milliseconds: 1), () {
      _tasksController.add(_tasks.where((TaskModel t) => t.listId == listId));
    });
    return _tasksController.stream;
  }

  ///
  @override
  Future<Null> addTask(String name, String listId) => new Future<Null>(() {
        final Uuid uuid = new Uuid();
        _tasks.add(new TaskModel.fromMap(<String, dynamic>{
          '_id': uuid.v4(),
          'name': name,
          'completed': false
        }, listId));
        _tasksController.add(_tasks.where((TaskModel t) => t.listId == listId));
      });

  @override
  Future<Null> removeTask(String taskId, String listId) =>
      new Future<Null>.value(null);
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
  Future<Null> addList(ListModel list, String userId) => _firestore
      .collection('lists')
      .document()
      .setData(_listToMap(list: list, owner: userId));

  ///
  @override
  Future<Null> removeList(String listId) =>
      _firestore.collection('lists').document(listId).delete();

  @override
  Observable<Iterable<TaskModel>> tasks({String listId}) =>
      new Observable<Iterable<DocumentSnapshot>>(_firestore
              .collection('lists/$listId/tasks')
              .snapshots
              .map((QuerySnapshot q) => q.documents))
          .defaultIfEmpty(<DocumentSnapshot>[]).map(
              (Iterable<DocumentSnapshot> d) =>
                  d.map((DocumentSnapshot d) => _taskFromMap(d, listId)));

  ///
  @override
  Future<Null> addTask(String name, String listId) => _firestore
      .collection('lists/$listId/tasks')
      .document()
      .setData(<String, dynamic>{'name': name, 'completed': false});

  ///
  @override
  Future<Null> removeTask(String taskId, String listId) =>
      _firestore.document('lists/$listId/tasks/$taskId').delete();

  ///
  Map<String, dynamic> _listToMap({ListModel list, String owner}) =>
      <String, dynamic>{'name': list.name, 'owner': owner};

  ///
  ListModel _listFromMap(DocumentSnapshot document) {
    final Map<String, dynamic> data =
        new Map<String, dynamic>.from(document.data);
    data['_id'] = document.documentID;
    return new ListModel.fromMap(data);
  }

  ///
  TaskModel _taskFromMap(DocumentSnapshot document, String listId) {
    final Map<String, dynamic> data =
        new Map<String, dynamic>.from(document.data);
    data['_id'] = document.documentID;
    return new TaskModel.fromMap(data, listId);
  }
}
