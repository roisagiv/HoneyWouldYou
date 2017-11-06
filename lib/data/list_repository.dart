import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/data/serializers.dart';
import 'package:rxdart/rxdart.dart';

///
class ListRepository {
  ///
  const ListRepository();

  ///
  Observable<List<ListModel>> listsAsObserable() =>
      new Observable<List<ListModel>>.fromFuture(loadJson()
          .then((String json) => JSON.decode(json))
          .then((map) => map
              .map((item) =>
                  serializers.deserializeWith(ListModel.serializer, item))
              .toList()));

  ///
  Future<Iterable<ListModel>> listsAsFuture() => loadJson()
      .then((String json) => JSON.decode(json))
      .then((List<dynamic> map) => map
          .map((Map<String, dynamic> item) => new ListModel.fromMap(item))
          .toList());

  ///
  Future<String> loadJson() => rootBundle.loadString('assets/mock/lists.json');
}
