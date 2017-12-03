library honeywouldyou.redux;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:honeywouldyou/auth/redux.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/lists/redux.dart';
import 'package:honeywouldyou/services.dart';
import 'package:honeywouldyou/splash/redux.dart';
import 'package:honeywouldyou/tasks/redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

export 'package:honeywouldyou/auth/redux.dart';
export 'package:honeywouldyou/splash/redux.dart';
export 'package:honeywouldyou/tasks/redux.dart';

part 'redux.g.dart';

///
Store<AppState> createStore(
    {Repository repository,
    Authenticator authenticator,
    bool logging = false}) {
  final List<Middleware<AppState>> middleware = <Middleware<AppState>>[
    new EpicMiddleware<AppState>(combineEpics(<Epic<AppState>>[
      rootAuthEpic(authenticator),
      rootListsEpic(repository: repository),
      rootTasksEpic(repository: repository),
      new SplashEpic(authenticator),
    ])),
    new LoggingMiddleware<AppState>.printer(
        formatter: LoggingMiddleware.singleLineFormatter)
  ];

  if (logging == false) {
    middleware.removeLast();
  }

  return new Store<AppState>(
      combineReducers(<Reducer<AppState>>[
        new ListsReducer(),
        new TasksReducer(),
        new AuthReducer(),
        new SplashReducer()
      ]),
      initialState: new AppState((AppStateBuilder b) =>
          b.authentication = new AuthenticationModelBuilder()
            ..authenticationStatus = AuthenticationStatus.notAuthenticated),
      middleware: middleware);
}

///
abstract class AppState implements Built<AppState, AppStateBuilder> {
  ///
  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  ///
  AppState._();

  ///
  BuiltMap<String, ListModel> get lists;

  ///
  BuiltMap<String, TaskModel> get tasks;

  ///
  AuthenticationModel get authentication;
}

///
abstract class AuthenticationModel
    implements Built<AuthenticationModel, AuthenticationModelBuilder> {
  ///
  factory AuthenticationModel([updates(AuthenticationModelBuilder b)]) =
      _$AuthenticationModel;

  ///
  AuthenticationModel._();

  ///
  @nullable
  UserModel get currentUser;

  ///
  AuthenticationStatus get authenticationStatus;

  ///
  @nullable
  String get errorMessage;
}

///
abstract class Action<Payload, Meta> {
  ///
  Payload payload;

  ///
  final Error error;

  ///
  final Meta metadata;

  ///
  Action({this.payload, this.error, this.metadata});

  ///
  String get type => '$runtimeType';
}

///
class OnRepositoryTaskCompletedAction extends Action<Null, Null> {}
