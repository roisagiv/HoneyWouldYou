library redux;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/home/redux.dart';
import 'package:honeywouldyou/tasks/redux.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

part 'redux.g.dart';

///
Store<AppState> createStore(ListRepository listRepository,
    {bool logging = false}) {
  final middlewares = [
    new EpicMiddleware(new HomeEpic(listRepository)),
    new LoggingMiddleware(
        formatter: LoggingMiddleware.multiLineFormatter, level: Level.INFO)
  ];

  if (logging == false) {
    middlewares.removeLast();
  }

  return new Store<AppState>(
      combineReducers([new HomeReducer(), new TasksReducer()]),
      initialState: new AppStateBuilder().build(),
      middleware: middlewares);
}

///
abstract class AppState implements Built<AppState, AppStateBuilder> {
  ///
  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  ///
  AppState._();

  ///
  BuiltList<ListModel> get lists;
}

///
abstract class Action<Payload, Meta> {
  ///
  final String type;

  ///
  Payload payload;

  ///
  final Error error;

  ///
  final Meta metadata;

  ///
  Action({this.type, this.payload, this.error, this.metadata});
}
