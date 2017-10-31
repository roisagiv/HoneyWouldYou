import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

///
class TasksReducer extends ReducerClass<AppState> {
  ///
  @override
  AppState call(AppState state, @checked Action action) {
    switch (action.runtimeType) {
      case OnTaskCompleteToggledAction:
        return _onTaskCompleteToggled(state, action);
      case OnAddTaskAction:
        return _onAddTask(state, action);
    }
    return state.toBuilder().build();
  }

  AppState _onTaskCompleteToggled(
      AppState state, OnTaskCompleteToggledAction action) {
    var updatedList =
        state.lists.singleWhere((l) => l.id == action.payload.listId);
    final updatedListIndex = state.lists.indexOf(updatedList);

    var updatedTask =
        updatedList.tasks.singleWhere((t) => t.id == action.payload.taskId);
    final updatedTaskIndex = updatedList.tasks.indexOf(updatedTask);

    updatedTask =
        updatedTask.rebuild((b) => b.completed = action.payload.completed);

    updatedList = updatedList.rebuild((b) => b.tasks = updatedList.tasks
        .rebuild((b) => b.replaceRange(
            updatedTaskIndex, updatedTaskIndex + 1, [updatedTask]))
        .toBuilder());

    return state.rebuild((b) => b
      ..lists = state.lists
          .rebuild((b) => b.replaceRange(
              updatedListIndex, updatedListIndex + 1, [updatedList]))
          .toBuilder());
  }

  AppState _onAddTask(AppState state, OnAddTaskAction action) {
    var updatedList =
        state.lists.singleWhere((l) => l.id == action.payload.listId);
    final updatedListIndex = state.lists.indexOf(updatedList);

    updatedList = updatedList.rebuild((b) => b.tasks.add(new TaskModel((b) {
          b.id = '123';
          b.completed = false;
          return b.name = action.payload.name;
        })));

    return state.rebuild((b) => b
      ..lists = state.lists
          .rebuild((b) => b.replaceRange(
              updatedListIndex, updatedListIndex + 1, [updatedList]))
          .toBuilder());
  }
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
  OnTaskCompleteToggledAction(payload)
      : super(type: 'OnTaskCompleteToggledAction', payload: payload);
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
  OnAddTaskAction(payload) : super(type: 'OnAddTaskAction', payload: payload);
}
