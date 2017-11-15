// GENERATED CODE - DO NOT MODIFY BY HAND

part of honeywouldyou.redux;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$AppState extends AppState {
  @override
  final BuiltMap<String, ListModel> lists;
  @override
  final BuiltMap<String, TaskModel> tasks;
  @override
  final AuthenticationModel authentication;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.lists, this.tasks, this.authentication}) : super._() {
    if (lists == null) throw new ArgumentError.notNull('lists');
    if (tasks == null) throw new ArgumentError.notNull('tasks');
    if (authentication == null)
      throw new ArgumentError.notNull('authentication');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return lists == other.lists &&
        tasks == other.tasks &&
        authentication == other.authentication;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, lists.hashCode), tasks.hashCode), authentication.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('lists', lists)
          ..add('tasks', tasks)
          ..add('authentication', authentication))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  MapBuilder<String, ListModel> _lists;
  MapBuilder<String, ListModel> get lists =>
      _$this._lists ??= new MapBuilder<String, ListModel>();
  set lists(MapBuilder<String, ListModel> lists) => _$this._lists = lists;

  MapBuilder<String, TaskModel> _tasks;
  MapBuilder<String, TaskModel> get tasks =>
      _$this._tasks ??= new MapBuilder<String, TaskModel>();
  set tasks(MapBuilder<String, TaskModel> tasks) => _$this._tasks = tasks;

  AuthenticationModelBuilder _authentication;
  AuthenticationModelBuilder get authentication =>
      _$this._authentication ??= new AuthenticationModelBuilder();
  set authentication(AuthenticationModelBuilder authentication) =>
      _$this._authentication = authentication;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _lists = _$v.lists?.toBuilder();
      _tasks = _$v.tasks?.toBuilder();
      _authentication = _$v.authentication?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    final _$result = _$v ??
        new _$AppState._(
            lists: lists?.build(),
            tasks: tasks?.build(),
            authentication: authentication?.build());
    replace(_$result);
    return _$result;
  }
}

class _$AuthenticationModel extends AuthenticationModel {
  @override
  final UserModel currentUser;
  @override
  final AuthenticationStatus authenticationStatus;
  @override
  final String errorMessage;

  factory _$AuthenticationModel([void updates(AuthenticationModelBuilder b)]) =>
      (new AuthenticationModelBuilder()..update(updates)).build();

  _$AuthenticationModel._(
      {this.currentUser, this.authenticationStatus, this.errorMessage})
      : super._() {
    if (authenticationStatus == null)
      throw new ArgumentError.notNull('authenticationStatus');
  }

  @override
  AuthenticationModel rebuild(void updates(AuthenticationModelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthenticationModelBuilder toBuilder() =>
      new AuthenticationModelBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AuthenticationModel) return false;
    return currentUser == other.currentUser &&
        authenticationStatus == other.authenticationStatus &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, currentUser.hashCode), authenticationStatus.hashCode),
        errorMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthenticationModel')
          ..add('currentUser', currentUser)
          ..add('authenticationStatus', authenticationStatus)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class AuthenticationModelBuilder
    implements Builder<AuthenticationModel, AuthenticationModelBuilder> {
  _$AuthenticationModel _$v;

  UserModelBuilder _currentUser;
  UserModelBuilder get currentUser =>
      _$this._currentUser ??= new UserModelBuilder();
  set currentUser(UserModelBuilder currentUser) =>
      _$this._currentUser = currentUser;

  AuthenticationStatus _authenticationStatus;
  AuthenticationStatus get authenticationStatus => _$this._authenticationStatus;
  set authenticationStatus(AuthenticationStatus authenticationStatus) =>
      _$this._authenticationStatus = authenticationStatus;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  AuthenticationModelBuilder();

  AuthenticationModelBuilder get _$this {
    if (_$v != null) {
      _currentUser = _$v.currentUser?.toBuilder();
      _authenticationStatus = _$v.authenticationStatus;
      _errorMessage = _$v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthenticationModel other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AuthenticationModel;
  }

  @override
  void update(void updates(AuthenticationModelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthenticationModel build() {
    final _$result = _$v ??
        new _$AuthenticationModel._(
            currentUser: _currentUser?.build(),
            authenticationStatus: authenticationStatus,
            errorMessage: errorMessage);
    replace(_$result);
    return _$result;
  }
}
