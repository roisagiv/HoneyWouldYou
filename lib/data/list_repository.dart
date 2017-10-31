import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/data/serializers.dart';
import 'package:rxdart/rxdart.dart';

///
class ListRepository {
  ///
  Observable<List<ListModel>> listsAsObserable() => new Observable.fromFuture(
      loadJson().then((json) => JSON.decode(json)).then((map) => map
          .map(
              (item) => serializers.deserializeWith(ListModel.serializer, item))
          .toList()));

  ///
  Future<List<ListModel>> listsAsFuture() => loadJson()
      .then((json) => JSON.decode(json))
      .then((map) => map.map((item) => new ListModel.fromMap(item)).toList());

  ///
  Future<String> loadJson() => rootBundle.loadString('assets/mock/lists.json');
}
