import 'dart:async';

import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

///
class HomeReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, @checked Action<dynamic, dynamic> action) {
    if (action is OnDataRefreshAction) {
      return state
          .rebuild((AppStateBuilder b) => b..lists.replace(action.payload));
    }
    if (action is OnAddNewListSaveClickedAction) {
      return state.rebuild((AppStateBuilder b) => b
        ..lists.add(new ListModel((ListModelBuilder b) => b
          ..name = action.payload
          ..id = '')));
    }
    return state;
  }
}

///
class HomeEpic extends EpicClass<AppState> {
  final ListRepository _listRepository;

  ///
  HomeEpic(this._listRepository);

  ///
  @override
  Stream<dynamic> call(
          @checked Stream<dynamic> actions, EpicStore<AppState> store) =>
      actions
          .where((Action<dynamic, dynamic> action) =>
              action is OnHomePageConnectedAction)
          .asyncMap((Action<dynamic, dynamic> action) => _listRepository
              .listsAsFuture()
              .then((Iterable<ListModel> lists) =>
                  new OnDataRefreshAction(lists)));
}

///
class OnHomePageConnectedAction extends Action<Null, Null> {}

///
class OnDataRefreshAction extends Action<List<ListModel>, Null> {
  ///
  OnDataRefreshAction(List<ListModel> payload) : super(payload: payload);
}

///
class OnAddNewListSaveClickedAction extends Action<String, Null> {
  ///
  OnAddNewListSaveClickedAction(String payload) : super(payload: payload);
}
