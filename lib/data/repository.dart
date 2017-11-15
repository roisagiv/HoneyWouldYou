import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:honeywouldyou/data/models.dart';

///
abstract class Repository {
  ///
  Stream<List<ListModel>> lists(String userId);

  ///
  Stream<List<TaskModel>> tasks({String userId, String listId});
}

///
class LocalFileRepository implements Repository {
  ///
  Future<String> loadJson() => rootBundle.loadString('assets/mock/lists.json');

  @override
  Stream<List<ListModel>> lists(String userId) => loadJson()
      .then((String json) => JSON.decode(json))
      .then((Map<String, dynamic> map) => map['lists']
          .map((Map<String, dynamic> item) => new ListModel.fromMap(item)))
      .asStream();

  ///
  @override
  Stream<List<TaskModel>> tasks({String userId, String listId}) => loadJson()
      .then((String json) => JSON.decode(json))
      .then((Map<String, dynamic> map) => map['tasks'].map(
          (Map<String, dynamic> item) => new TaskModel.fromMap(item, listId)))
      .asStream();
}

///
class FirestoreRepository implements Repository {
  final Firestore _firestore;

  ///
  const FirestoreRepository(this._firestore);

  ///
  @override
  Stream<List<ListModel>> lists(String userId) => _firestore
      .collection('lists')
      .where('owner', isEqualTo: userId)
      .snapshots
      .asyncMap((QuerySnapshot q) => q.documents)
      .map((List<DocumentSnapshot> ds) => ds
          .map((DocumentSnapshot d) => new ListModel((ListModelBuilder b) => b
            ..name = d['name']
            ..id = d.documentID
            ..tasksCount = d['tasksCount']
            ..build()))
          .toList());

  ///
  @override
  Stream<List<TaskModel>> tasks({String userId, String listId}) => _firestore
      .collection('tasks')
      .where('owner', isEqualTo: userId)
      .where('listId', isEqualTo: listId)
      .snapshots
      .asyncMap((QuerySnapshot q) => q.documents)
      .map((List<DocumentSnapshot> ds) => ds
          .map((DocumentSnapshot d) => new TaskModel((TaskModelBuilder b) => b
            ..id = d.documentID
            ..name = d['name']
            ..listId = listId
            ..completed = d['completed']
            ..build()))
          .toList());
}
