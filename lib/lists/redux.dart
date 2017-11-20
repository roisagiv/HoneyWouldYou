import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/services.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

///
class ListsReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, @checked Action<dynamic, dynamic> action) {
    if (action is OnDataRefreshAction) {
      return state.rebuild((AppStateBuilder b) => b.lists
        ..clear()
        ..addIterable(action.payload, key: (ListModel l) => l.id));
    }
    return state;
  }
}

/**
 * Epics
 */

///
class _OnConnectEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  _OnConnectEpic(this._repository);

  ///
  @override
  Stream<dynamic> call(
          @checked Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where(
              (Action<dynamic, dynamic> a) => a is OnListsPageConnectedAction)
          .flatMap((Action<dynamic, dynamic> a) =>
              _repository.lists(store.state.authentication.currentUser.uid))
          .map((Iterable<ListModel> lists) => new OnDataRefreshAction(lists));
}

///
class _OnRemoveNewListEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  _OnRemoveNewListEpic(this._repository);

  ///
  @override
  Stream<dynamic> call(
          @checked Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where((Action<dynamic, dynamic> action) =>
              action is OnRemoveListClickedAction)
          .asyncMap((Action<dynamic, dynamic> action) =>
              _repository.remove(action.payload))
          .map((Null _) => new OnRepositoryTaskCompletedAction());
}

///
class _OnAddNewListEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  _OnAddNewListEpic(this._repository);

  ///
  @override
  Stream<dynamic> call(
          @checked Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where((Action<dynamic, dynamic> action) =>
              action is OnAddNewListSaveClickedAction)
          .asyncMap((Action<dynamic, dynamic> action) => _repository.add(
              new ListModel((ListModelBuilder b) => b
                ..id = '0'
                ..name = action.payload
                ..tasks = new MapBuilder<String, TaskModel>()
                ..build()),
              store.state.authentication.currentUser.uid))
          .map((Null _) => new OnRepositoryTaskCompletedAction());
}

///
Epic<AppState> rootListsEpic({Repository repository}) =>
    combineEpics(<Epic<AppState>>[
      new _OnConnectEpic(repository),
      new _OnAddNewListEpic(repository),
      new _OnRemoveNewListEpic(repository)
    ]);

///
class OnListsPageConnectedAction extends Action<Null, Null> {}

///
class OnRepositoryTaskCompletedAction extends Action<Null, Null> {}

///
class OnDataRefreshAction extends Action<Iterable<ListModel>, Null> {
  ///
  OnDataRefreshAction(Iterable<ListModel> payload) : super(payload: payload);
}

///
class OnAddNewListSaveClickedAction extends Action<String, Null> {
  ///
  OnAddNewListSaveClickedAction(String payload) : super(payload: payload);
}

///
class OnRemoveListClickedAction extends Action<String, Null> {
  ///
  OnRemoveListClickedAction(String payload) : super(payload: payload);
}
