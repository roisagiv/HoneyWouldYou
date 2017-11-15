import 'dart:async';

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
      return state.rebuild((AppStateBuilder b) =>
          b..lists.addIterable(action.payload, key: (ListModel l) => l.id));
    }
    if (action is OnAddNewListSaveClickedAction) {
      final ListModel listModel = new ListModel((ListModelBuilder b) => b
        ..name = action.payload
        ..tasksCount = 0
        ..id = '349343');
      return state.rebuild((AppStateBuilder b) =>
          b..lists.addAll(<String, ListModel>{listModel.id: listModel}));
    }
    return state;
  }
}

///
class ListsEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  ListsEpic(this._repository);

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
class OnListsPageConnectedAction extends Action<Null, Null> {}

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
