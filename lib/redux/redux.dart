library redux;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/auth/redux.dart';
import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/home/redux.dart';
import 'package:honeywouldyou/splash/redux.dart';
import 'package:honeywouldyou/tasks/redux.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

export 'package:honeywouldyou/auth/redux.dart';
export 'package:honeywouldyou/home/redux.dart';
export 'package:honeywouldyou/splash/redux.dart';
export 'package:honeywouldyou/tasks/redux.dart';

part 'redux.g.dart';

///
Store<AppState> createStore(
    {ListRepository listRepository = const ListRepository(),
    Authenticator authenticator,
    bool logging = false}) {
  final List<Middleware<AppState>> middleware = <Middleware<AppState>>[
    new EpicMiddleware<AppState>(combineEpics(<Epic<AppState>>[
      new SignOutEpic(authenticator),
      new HomeEpic(listRepository),
      new SplashEpic(authenticator)
    ])),
    new LoggingMiddleware<AppState>(
        formatter: LoggingMiddleware.multiLineFormatter, level: Level.INFO)
  ];

  if (logging == false) {
    middleware.removeLast();
  }

  return new Store<AppState>(
      combineReducers(<Reducer<AppState>>[
        new HomeReducer(),
        new TasksReducer(),
        new AuthReducer(),
        new SplashReducer()
      ]),
      initialState: new AppState((AppStateBuilder b) =>
          b.authentication = new AuthenticationBuilder()
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
  BuiltList<ListModel> get lists;

  ///
  Authentication get authentication;
}

///
abstract class Authentication
    implements Built<Authentication, AuthenticationBuilder> {
  ///
  factory Authentication([updates(AuthenticationBuilder b)]) = _$Authentication;

  ///
  Authentication._();

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
