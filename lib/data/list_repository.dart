import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:honeywouldyou/data/models.dart';

///
class ListRepository {
  ///
  const ListRepository();

  ///
  Future<Iterable<ListModel>> listsAsFuture() => loadJson()
      .then((String json) => JSON.decode(json))
      .then((List<dynamic> map) => map
          .map((Map<String, dynamic> item) => new ListModel.fromMap(item))
          .toList());

  ///
  Future<String> loadJson() => rootBundle.loadString('assets/mock/lists.json');
}
