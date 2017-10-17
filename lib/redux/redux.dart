import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/home/models.dart';
import 'package:honeywouldyou/home/redux.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

///
Store<AppState> createStore(ListRepository listRepository) =>
    new Store<AppState>(new RootReducer(),
        initialState: new AppState([]),
        middleware: [
          new EpicMiddleware(new HomeEpic(listRepository)),
          new LoggingMiddleware.printer(
              level: Level.INFO,
              formatter: LoggingMiddleware.multiLineFormatter),
        ]);

///
@immutable
class AppState {
  ///
  final List<ListModel> lists;

  ///
  const AppState(this.lists);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          lists == other.lists;

  @override
  int get hashCode => lists.hashCode;
}

///
abstract class Action<Payload, Meta> {
  ///
  final String type;

  ///
  Payload payload;

  ///
  final Error error;

  ///
  final Meta metadata;

  ///
  Action({this.type, this.payload, this.error, this.metadata});
}
