import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/lists/redux.dart';
import 'package:honeywouldyou/navigation.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/theme.dart';
import 'package:honeywouldyou/widgets/main_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

///
typedef void NewListItem(String name);

///
typedef void RemoveListItem(String listId);

@immutable
class _ViewModel {
  final List<ListModel> lists;
  final NewListItem newListItemFunction;
  final RemoveListItem removeListItemFunction;
  final VoidCallback onLogoutButtonClicked;

  const _ViewModel(
      {this.lists,
      this.newListItemFunction,
      this.onLogoutButtonClicked,
      this.removeListItemFunction});
}

///
class ListsPage extends StatelessWidget {
  final Navigation _navigation;

  ///
  const ListsPage(this._navigation);

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, _ViewModel>(
        onInit: (Store<dynamic> store) =>
            store.dispatch(new OnListsPageConnectedAction()),
        converter: (Store<AppState> store) => new _ViewModel(
            lists: store.state.lists.values.toList(),
            newListItemFunction: (String name) =>
                store.dispatch(new OnAddNewListSaveClickedAction(name)),
            removeListItemFunction: (String listId) =>
                store.dispatch(new OnRemoveListClickedAction(listId)),
            onLogoutButtonClicked: () =>
                store.dispatch(new OnSignOutButtonClickedAction())),
        builder: (BuildContext context, _ViewModel viewModel) => new Scaffold(
              appBar: _buildAppBar(context, viewModel),
              body: new Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.screenEdgeMargin),
                child: new ListsWidget(_navigation, viewModel),
              ),
              bottomNavigationBar: new Container(
                height: AppDimens.bottomNavigationBarHeight,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        onPressed: () => _addNewList(context, viewModel),
                        child: new Text('+ ADD NEW LIST'),
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
      );

  ///
  MainAppBar _buildAppBar(BuildContext context, _ViewModel viewModel) =>
      new MainAppBar(
        title: new Text(
          'Today',
          style: AppTextStyles.appBarTitle(context),
        ),
        subtitle: new Text(
          new DateFormat("EEE, MMM d, ''yy").format(new DateTime.now()),
          style: AppTextStyles.appBarSubtitle(context),
        ),
        actions: <Widget>[
          new PopupMenuButton<String>(
              icon: new Icon(
                Icons.more_vert,
                color: AppColors.black,
              ),
              onSelected: (String value) => viewModel.onLogoutButtonClicked(),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    new PopupMenuItem<String>(
                      child: new ListTile(
                        dense: true,
                        leading: new Icon(Icons.person_outline),
                        title: new Text('Logout'),
                      ),
                      value: 'Logout',
                    )
                  ]),
        ],
      );

  Future<dynamic> _addNewList(BuildContext context, _ViewModel viewModel) {
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
                viewModel.newListItemFunction(fieldController.text);
              })
        ],
      ),
    );
  }
}

///
class ListsWidget extends StatelessWidget {
  final _ViewModel _viewModel;

  final Navigation _navigation;

  ///
  const ListsWidget(this._navigation, this._viewModel);

  @override
  Widget build(BuildContext context) => new ListView.builder(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.listViewPadding + AppDimens.screenEdgeMargin,
            horizontal: AppDimens.listViewPadding),
        itemBuilder: (BuildContext context, int index) => new ListItemWidget(
            _viewModel.lists[index], _navigation, _viewModel),
        itemCount: _viewModel.lists.length,
      );
}

///
class ListItemWidget extends StatelessWidget {
  ///
  final ListModel _list;
  final _ViewModel _viewModel;
  final Navigation _navigation;

  ///
  const ListItemWidget(this._list, this._navigation, this._viewModel);

  @override
  Widget build(BuildContext context) {
    const double size = AppDimens.listItemHeight;
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new Card(
          elevation: 1.0,
          child: new Container(
              height: size,
              child: new InkWell(
                onTap: () => _navigation.navigateTo(
                    context, '/lists/${_list.id}',
                    transition: TransitionType.native),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Container(
                      color: AppColors.radicalRed,
                      width: size,
                      child: new Icon(
                        Icons.router,
                        color: AppColors.snow,
                        size: size / 2,
                      ),
                    ),
                    new Flexible(
                        flex: 1,
                        child: new Container(
                          padding: const EdgeInsets.all(12.0),
                          constraints: const BoxConstraints.expand(),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                _list.name,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              new Text(
                                '${4} Tasks',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )),
                    new PopupMenuButton<String>(
                        icon: new Icon(
                          Icons.more_vert,
                          color: AppColors.manatee,
                        ),
                        onSelected: (String _) =>
                            _viewModel.removeListItemFunction(_list.id),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              new PopupMenuItem<String>(
                                  value: 'delete',
                                  child: new ListTile(
                                    dense: true,
                                    leading: new Icon(Icons.delete),
                                    title: new Text('Delete'),
                                  )),
                            ]),
                  ],
                ),
              ))),
    );
  }
}
