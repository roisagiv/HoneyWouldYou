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
class TasksReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, @checked Action<dynamic, dynamic> action) {
    switch (action.runtimeType) {
      case OnTaskCompleteToggledAction:
        return _onTaskCompleteToggled(state, action);
      case OnNewTasksDataAction:
        return _onNewTasksDataAction(state, action);
    }
    return state.toBuilder().build();
  }

  ///
  AppState _onTaskCompleteToggled(
      AppState state, OnTaskCompleteToggledAction action) {
    TaskModel updatedTask = state.tasks[action.payload.taskId];

    updatedTask = updatedTask.rebuild(
        (TaskModelBuilder b) => b.completed = action.payload.completed);

    return state.rebuild((AppStateBuilder b) => b
      ..tasks = state.tasks
          .rebuild((MapBuilder<String, TaskModel> b) =>
              b[updatedTask.id] = updatedTask)
          .toBuilder());
  }

  ///
  AppState _onNewTasksDataAction(AppState state, OnNewTasksDataAction action) =>
      state.rebuild((AppStateBuilder b) => b.tasks
        ..clear()
        ..addIterable(action.payload, key: (TaskModel t) => t.id));
}

/**
 * Epics
 */

///
class _OnTasksPageConnectedEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  _OnTasksPageConnectedEpic(this._repository);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where((Action<dynamic, dynamic> action) =>
              action is OnTasksPageConnectedAction)
          .flatMap((Action<dynamic, dynamic> action) => _repository
              .tasks(listId: action.payload)
              .defaultIfEmpty(<TaskModel>[]))
          .map((Iterable<TaskModel> tasks) => new OnNewTasksDataAction(tasks));
}

///
class _OnAddTaskEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  _OnAddTaskEpic(this._repository);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where((Action<dynamic, dynamic> action) => action is OnAddTaskAction)
          .flatMap((Action<dynamic, dynamic> action) => _repository
              .addTask(action.payload.name, action.payload.listId)
              .asStream()
              .map((Null _) => new OnRepositoryTaskCompletedAction()));
}

///
class _OnRemoveTaskEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  _OnRemoveTaskEpic(this._repository);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where(
              (Action<dynamic, dynamic> action) => action is OnRemoveTaskAction)
          .flatMap((Action<dynamic, dynamic> action) => _repository
              .removeTask(action.payload.taskId, action.payload.listId)
              .asStream()
              .map((Null _) => new OnRepositoryTaskCompletedAction()));
}

///
Epic<AppState> rootTasksEpic({Repository repository}) =>
    combineEpics(<Epic<AppState>>[
      new _OnTasksPageConnectedEpic(repository),
      new _OnAddTaskEpic(repository),
      new _OnRemoveTaskEpic(repository)
    ]);

/**
 * Actions
 */

///
class OnTasksPageConnectedAction extends Action<String, Null> {
  ///
  OnTasksPageConnectedAction({String listId}) : super(payload: listId);
}

///
class OnNewTasksDataAction extends Action<Iterable<TaskModel>, Null> {
  ///
  OnNewTasksDataAction(Iterable<TaskModel> payload) : super(payload: payload);
}

///
class OnTaskCompleteToggledData {
  ///
  final String taskId;

  ///
  final String listId;

  ///
  final bool completed;

  ///
  const OnTaskCompleteToggledData({this.taskId, this.listId, this.completed});
}

///
class OnTaskCompleteToggledAction
    extends Action<OnTaskCompleteToggledData, Null> {
  ///
  OnTaskCompleteToggledAction(OnTaskCompleteToggledData payload)
      : super(payload: payload);
}

///
class OnAddTaskActionData {
  ///
  final String listId;

  ///
  final String name;

  ///
  OnAddTaskActionData({this.listId, this.name});
}

///
class OnAddTaskAction extends Action<OnAddTaskActionData, Null> {
  ///
  OnAddTaskAction(OnAddTaskActionData payload) : super(payload: payload);
}

class _OnRemoveTaskActionData {
  final String listId;
  final String taskId;

  _OnRemoveTaskActionData(this.listId, this.taskId);
}

///
class OnRemoveTaskAction extends Action<_OnRemoveTaskActionData, Null> {
  ///
  OnRemoveTaskAction(
      {@required final String listId, @required final String taskId})
      : super(payload: new _OnRemoveTaskActionData(listId, taskId));
}
