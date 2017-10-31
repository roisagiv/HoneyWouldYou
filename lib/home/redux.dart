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
  AppState call(AppState state, @checked Action action) {
    if (action is OnDataRefreshAction) {
      return new AppState((b) => b..lists.replace(action.payload));
    }
    if (action is OnAddNewListSaveClickedAction) {
      return state.rebuild((b) => b
        ..lists.add(new ListModel((b) => b
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
