import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:honeywouldyou/home/models.dart';
import 'package:rxdart/rxdart.dart';

///
class ListRepository {
  ///
  Observable<List<ListModel>> listsAsObserable() =>
      new Observable.fromFuture(rootBundle
          .loadString('assets/mock/lists.json')
          .then((json) => JSON.decode(json))
          .then((map) =>
              map.map((item) => new ListModel.fromJson(item)).toList()));

  ///
  Future<List<ListModel>> listsAsFuture() => rootBundle
      .loadString('assets/mock/lists.json')
      .then((json) => JSON.decode(json))
      .then((map) => map.map((item) => new ListModel.fromJson(item)).toList());
}
