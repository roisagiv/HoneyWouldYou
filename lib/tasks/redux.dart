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
      case OnAddTaskAction:
        return _onAddTask(state, action);
      case OnNewTasksDataAction:
        return _onNewTasksDataAction(state, action);
    }
    return state.toBuilder().build();
  }

  AppState _onTaskCompleteToggled(
      AppState state, OnTaskCompleteToggledAction action) {
    TaskModel updatedTask = state.tasks.values
        .singleWhere((TaskModel t) => t.id == action.payload.taskId);

    updatedTask = updatedTask.rebuild(
        (TaskModelBuilder b) => b.completed = action.payload.completed);

    return state.rebuild((AppStateBuilder b) => b
      ..tasks = state.tasks
          .rebuild((MapBuilder<String, TaskModel> b) =>
              b[updatedTask.id] = updatedTask)
          .toBuilder());
  }

  AppState _onAddTask(AppState state, OnAddTaskAction action) {
    final TaskModel taskModel = new TaskModel((TaskModelBuilder b) {
      b
        ..id = '123'
        ..listId = action.payload.listId
        ..completed = false;
      return b.name = action.payload.name;
    });

    return state.rebuild((AppStateBuilder b) => b
      ..tasks = state.tasks
          .rebuild((MapBuilder<String, TaskModel> b) =>
              b.addAll(<String, TaskModel>{taskModel.id: taskModel}))
          .toBuilder());
  }

  AppState _onNewTasksDataAction(AppState state, OnNewTasksDataAction action) =>
      state.rebuild((AppStateBuilder b) =>
          b..tasks.addIterable(action.payload, key: (TaskModel t) => t.id));
}

/**
 * Epics
 */

///
class OnTasksPageConnectedEpic extends EpicClass<AppState> {
  final Repository _repository;

  ///
  OnTasksPageConnectedEpic(this._repository);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) =>
      new Observable<Action<dynamic, dynamic>>(actions)
          .where((Action<dynamic, dynamic> action) =>
              action is OnTasksPageConnectedAction)
          .flatMap((Action<dynamic, dynamic> action) => _repository.tasks(
              userId: store.state.authentication.currentUser.uid,
              listId: action.payload))
          .map((Iterable<TaskModel> tasks) => new OnNewTasksDataAction(tasks));
}

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
