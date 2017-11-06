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

///
class TasksPage extends StatelessWidget {
  final String _listId;

  ///
  const TasksPage(this._listId);

  ///
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => new _ViewModel(
              list: store.state.lists
                  .firstWhere((ListModel list) => list.id == _listId),
              onCompleteCheckBoxClicked: (String taskId, bool value) =>
                  store.dispatch(new OnTaskCompleteToggledAction(
                      new OnTaskCompleteToggledData(
                          listId: _listId, taskId: taskId, completed: value))),
              onTaskAdded: (String name) => store.dispatch(new OnAddTaskAction(
                  new OnAddTaskActionData(listId: _listId, name: name)))),
          builder: (BuildContext context, _ViewModel viewModel) => new Scaffold(
                appBar: new MainAppBar(
                  title: new Text(
                    viewModel.list.name,
                    style: AppTextStyles.appBarTitle(context),
                  ),
                  leading: const BackButton(
                    color: AppColors.manatee,
                  ),
                  subtitle: new Text(
                    '${viewModel.list.tasks.length} Tasks',
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
  Widget build(BuildContext context) => new ListView.builder(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.listViewPadding + AppDimens.screenEdgeMargin,
            horizontal: AppDimens.listViewPadding),
        itemBuilder: (BuildContext context, int index) =>
            new TaskListItemWidget(_viewModel.list.tasks[index],
                _viewModel.onCompleteCheckBoxClicked),
        itemCount: _viewModel.list.tasks.length,
      );
}

///
class TaskListItemWidget extends StatelessWidget {
  final TaskModel _task;
  final _OnTaskCompletedToggled _callback;

  ///
  const TaskListItemWidget(this._task, this._callback);

  ///
  @override
  Widget build(BuildContext context) => new InkWell(
        onTap: () => _callback(_task.id, !_task.completed),
        child: new Container(
          padding: const EdgeInsets.all(4.0),
          child: new Row(
            children: <Widget>[
              new Container(
                child: new Checkbox(
                  value: _task.completed,
                  onChanged: (bool value) => _callback(_task.id, value),
                ),
              ),
              new Text(
                _task.name,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
}

///
@immutable
class _ViewModel {
  final ListModel list;
  final _OnTaskCompletedToggled onCompleteCheckBoxClicked;
  final _OnTaskAdded onTaskAdded;

  ///
  const _ViewModel(
      {this.list, this.onCompleteCheckBoxClicked, this.onTaskAdded});
}
