import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/theme.dart';
import 'package:honeywouldyou/widgets/main_app_bar.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

typedef void _OnTaskCompletedToggled(String taskId, bool completed);
typedef void _OnTaskAdded(String name);
typedef void _OnTaskRemoved(String taskId);

///
class TasksPage extends StatelessWidget {
  final String _listId;

  ///
  const TasksPage(this._listId);

  ///
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, _ViewModel>(
          onInit: (Store<dynamic> store) =>
              store.dispatch(new OnTasksPageConnectedAction(listId: _listId)),
          converter: (Store<AppState> store) =>
          new _ViewModel(
              tasks: new List<TaskModel>.from(store.state.tasks.values
                  .where((TaskModel task) => task.listId == _listId)),
              list: store.state.lists[_listId],
              onCompleteCheckBoxClicked: (String taskId, bool value) =>
                  store.dispatch(new OnTaskCompleteToggledAction(
                      new OnTaskCompleteToggledData(
                          listId: _listId, taskId: taskId, completed: value))),
              onTaskAdded: (String name) =>
                  store.dispatch(new OnAddTaskAction(
                      new OnAddTaskActionData(listId: _listId, name: name))),
              onTaskRemoved: (String taskId) =>
                  store.dispatch(
                      new OnRemoveTaskAction(listId: _listId, taskId: taskId))),
          builder: (BuildContext context, _ViewModel viewModel) =>
          new Scaffold(
            appBar: new MainAppBar(
              title: new Text(
                viewModel.list.name,
                style: AppTextStyles.appBarTitle(context),
              ),
              leading: const BackButton(
                color: AppColors.manatee,
              ),
              subtitle: new Text(
                '${viewModel.list?.id} Tasks',
                style: AppTextStyles.appBarSubtitle(context),
              ),
            ),
            body: new Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.screenEdgeMargin),
              child: new TasksListWidget(viewModel),
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: () => _addNewTaskDialog(context, viewModel),
              child: new Icon(Icons.add),
            ),
          ));

  Future<Null> _addNewTaskDialog(BuildContext context, _ViewModel viewModel) {
    final TextEditingController fieldController = new TextEditingController();
    return showDialog(
        context: context,
        child: new AlertDialog(
          content: new Form(
              child: new TextField(
                controller: fieldController,
                decoration: const InputDecoration(hintText: 'Name'),
              )),
          actions: <Widget>[
            new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  viewModel.onTaskAdded(fieldController.text);
                })
          ],
        ));
  }
}

///
class TasksListWidget extends StatelessWidget {
  final _ViewModel _viewModel;

  ///
  const TasksListWidget(this._viewModel);

  ///
  @override
  Widget build(BuildContext context) =>
      new ListView.builder(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.listViewPadding + AppDimens.screenEdgeMargin,
            horizontal: AppDimens.listViewPadding),
        itemExtent: AppDimens.taskItemHeight,
        itemBuilder: (BuildContext context, int index) =>
        new TaskListItemWidget(
            _viewModel.tasks[index],
            _viewModel.onCompleteCheckBoxClicked,
            _viewModel.onTaskRemoved),
        itemCount: _viewModel.tasks.length,
      );
}

///
class TaskListItemWidget extends StatelessWidget {
  final TaskModel _task;
  final _OnTaskCompletedToggled _callback;
  final _OnTaskRemoved _taskRemovedCallback;

  ///
  const TaskListItemWidget(this._task, this._callback,
      this._taskRemovedCallback);

  ///
  @override
  Widget build(BuildContext context) =>
      new InkWell(
        onTap: () => _callback(_task.id, !_task.completed),
        child: new Container(
          padding: const EdgeInsets.all(4.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Checkbox(
                  value: _task.completed,
                  onChanged: (bool value) => _callback(_task.id, value),
                ),
              ),
              new Expanded(
                child: new Text(
                  _task.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new PopupMenuButton<String>(
                  icon: new Icon(
                    Icons.more_vert,
                    color: AppColors.black,
                  ),
                  onSelected: (String _) => _taskRemovedCallback(_task.id),
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<String>>[
                    new PopupMenuItem<String>(
                      child: new ListTile(
                        dense: true,
                        leading: new Icon(Icons.delete_outline),
                        title: new Text('Delete'),
                      ),
                      value: 'Logout',
                    )
                  ]),
            ],
          ),
        ),
      );
}

///
@immutable
class _ViewModel {
  final ListModel list;
  final List<TaskModel> tasks;
  final _OnTaskCompletedToggled onCompleteCheckBoxClicked;
  final _OnTaskAdded onTaskAdded;
  final _OnTaskRemoved onTaskRemoved;

  ///
  const _ViewModel({this.tasks,
    this.list,
    this.onCompleteCheckBoxClicked,
    this.onTaskAdded,
    this.onTaskRemoved});
}
