import 'package:built_collection/built_collection.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

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
    }
    return state.toBuilder().build();
  }

  AppState _onTaskCompleteToggled(
      AppState state, OnTaskCompleteToggledAction action) {
    ListModel updatedList =
        state.lists.singleWhere((ListModel l) => l.id == action.payload.listId);
    final int updatedListIndex = state.lists.indexOf(updatedList);

    TaskModel updatedTask = updatedList.tasks
        .singleWhere((TaskModel t) => t.id == action.payload.taskId);
    final int updatedTaskIndex = updatedList.tasks.indexOf(updatedTask);

    updatedTask = updatedTask.rebuild(
        (TaskModelBuilder b) => b.completed = action.payload.completed);

    updatedList = updatedList.rebuild((ListModelBuilder b) => b.tasks =
        updatedList.tasks
            .rebuild((ListBuilder<TaskModel> b) => b.replaceRange(
                updatedTaskIndex,
                updatedTaskIndex + 1,
                <TaskModel>[updatedTask]))
            .toBuilder());

    return state.rebuild((AppStateBuilder b) => b
      ..lists = state.lists
          .rebuild((ListBuilder<ListModel> b) => b.replaceRange(
              updatedListIndex, updatedListIndex + 1, <ListModel>[updatedList]))
          .toBuilder());
  }

  AppState _onAddTask(AppState state, OnAddTaskAction action) {
    ListModel updatedList =
        state.lists.singleWhere((ListModel l) => l.id == action.payload.listId);
    final int updatedListIndex = state.lists.indexOf(updatedList);

    updatedList = updatedList.rebuild(
        (ListModelBuilder b) => b.tasks.add(new TaskModel((TaskModelBuilder b) {
              b
                ..id = '123'
                ..completed = false;
              return b.name = action.payload.name;
            })));

    return state.rebuild((AppStateBuilder b) => b
      ..lists = state.lists
          .rebuild((ListBuilder<ListModel> b) => b.replaceRange(
              updatedListIndex, updatedListIndex + 1, <ListModel>[updatedList]))
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
