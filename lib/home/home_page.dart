import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/home/models.dart';
import 'package:honeywouldyou/home/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/theme.dart';
import 'package:honeywouldyou/widgets/MainAppBar.dart';
import 'package:meta/meta.dart';

///
typedef void NewListItem(String name);

@immutable
class _ViewModel {
  final List<ListModel> lists;
  final NewListItem newListItemFunction;
  final VoidCallback onAttachedFunction;

  const _ViewModel(
      this.lists, this.newListItemFunction, this.onAttachedFunction);
}

///
class HomePage extends StatelessWidget {
  ///
  const HomePage();

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, _ViewModel>(
        converter: (store) => new _ViewModel(
            store.state.lists,
            (name) => store.dispatch(new OnAddNewListSaveClickedAction(name)),
            () => store.dispatch(new OnHomePageConnectedAction())),
        builder: (context, viewModel) => new Scaffold(
              appBar: new MainAppBar(Theme.of(context).textTheme.display1),
              body: new Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.screenEdgeMargin),
                child: new ListsContainer(viewModel),
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

  Future _addNewList(BuildContext context, _ViewModel viewModel) {
    final fieldController = new TextEditingController();
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
class ListsContainer extends StatefulWidget {
  final _ViewModel _viewModel;

  ///
  const ListsContainer(this._viewModel);

  @override
  State createState() => new _ListsContainerState(_viewModel);
}

class _ListsContainerState extends State<ListsContainer> {
  final _ViewModel _viewModel;

  _ListsContainerState(this._viewModel);

  @override
  void initState() {
    super.initState();
    _viewModel.onAttachedFunction();
  }

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, List<ListModel>>(
          converter: (store) => store.state.lists,
          builder: (context, lists) => new ListsWidget(lists));
}

///
class ListsWidget extends StatelessWidget {
  ///
  final List<ListModel> lists;

  ///
  const ListsWidget(this.lists);

  @override
  Widget build(BuildContext context) => new ListView.builder(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.listViewPadding + AppDimens.screenEdgeMargin,
            horizontal: AppDimens.listViewPadding),
        itemBuilder: (context, index) => new ListItemWidget(lists[index]),
        itemCount: lists.length,
      );
}

///
class ListItemWidget extends StatelessWidget {
  ///
  final ListModel _list;

  ///
  const ListItemWidget(this._list);

  @override
  Widget build(BuildContext context) {
    const size = AppDimens.listItemHeight;
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new Card(
          elevation: 1.0,
          child: new Container(
              height: size,
              child: new InkWell(
                onTap: () => {},
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
                                _list.title,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              new Text(
                                '${_list.tasks.length} Tasks',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )),
                    new IconButton(
                      alignment: Alignment.centerRight,
                      icon: new Icon(Icons.more_vert),
                      onPressed: () => {},
                      color: AppColors.manatee,
                    )
                  ],
                ),
              ))),
    );
  }
}
