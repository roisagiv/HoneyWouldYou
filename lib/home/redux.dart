import 'dart:async';

import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/home/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

///
class RootReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, Action action) {
    if (action is OnDataRefreshAction) {
      return new AppState(action.payload);
    }
    if (action is OnAddNewListSaveClickedAction) {
      final lists = state.lists..add(new ListModel('', action.payload, []));
      return new AppState(lists);
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
  Stream<Action> call(Stream<Action> actions, EpicStore<AppState> store) =>
      actions.where((action) => action is OnHomePageConnectedAction).asyncMap(
          (action) => _listRepository
              .listsAsFuture()
              .then((lists) => new OnDataRefreshAction(lists)));
}

///
class OnHomePageConnectedAction extends Action<Null, Null> {
  ///
  OnHomePageConnectedAction() : super(type: 'OnHomePageConnectedAction');
}

///
class OnDataRefreshAction extends Action<List<ListModel>, Null> {
  ///
  OnDataRefreshAction(payload)
      : super(type: 'OnDataRefreshAction', payload: payload);
}

///
class OnAddNewListSaveClickedAction extends Action<String, Null> {
  ///
  OnAddNewListSaveClickedAction(payload)
      : super(type: 'OnAddNewListSaveClickedAction', payload: payload);
}
