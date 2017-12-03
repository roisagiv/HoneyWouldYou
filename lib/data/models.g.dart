// GENERATED CODE - DO NOT MODIFY BY HAND

part of honeywouldyou.models;

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

const AuthenticationStatus _$authenticated =
    const AuthenticationStatus._('authenticated');
const AuthenticationStatus _$notAuthenticated =
    const AuthenticationStatus._('notAuthenticated');
const AuthenticationStatus _$error = const AuthenticationStatus._('error');
const AuthenticationStatus _$inProgress =
    const AuthenticationStatus._('inProgress');
const AuthenticationStatus _$notDetemined =
    const AuthenticationStatus._('notDetemined');

AuthenticationStatus _$valueOf(String name) {
  switch (name) {
    case 'authenticated':
      return _$authenticated;
    case 'notAuthenticated':
      return _$notAuthenticated;
    case 'error':
      return _$error;
    case 'inProgress':
      return _$inProgress;
    case 'notDetemined':
      return _$notDetemined;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AuthenticationStatus> _$values =
    new BuiltSet<AuthenticationStatus>(const <AuthenticationStatus>[
  _$authenticated,
  _$notAuthenticated,
  _$error,
  _$inProgress,
  _$notDetemined,
]);

Serializer<TaskModel> _$taskModelSerializer = new _$TaskModelSerializer();
Serializer<ListModel> _$listModelSerializer = new _$ListModelSerializer();

class _$TaskModelSerializer implements StructuredSerializer<TaskModel> {
  @override
  final Iterable<Type> types = const [TaskModel, _$TaskModel];
  @override
  final String wireName = 'TaskModel';

  @override
  Iterable serialize(Serializers serializers, TaskModel object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'completed',
      serializers.serialize(object.completed,
          specifiedType: const FullType(bool)),
      'listId',
      serializers.serialize(object.listId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TaskModel deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new TaskModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'completed':
          result.completed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'listId':
          result.listId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ListModelSerializer implements StructuredSerializer<ListModel> {
  @override
  final Iterable<Type> types = const [ListModel, _$ListModel];
  @override
  final String wireName = 'ListModel';

  @override
  Iterable serialize(Serializers serializers, ListModel object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ListModel deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TaskModel extends TaskModel {
  @override
  final String id;
  @override
  final String name;
  @override
  final bool completed;
  @override
  final String listId;

  factory _$TaskModel([void updates(TaskModelBuilder b)]) =>
      (new TaskModelBuilder()..update(updates)).build();

  _$TaskModel._({this.id, this.name, this.completed, this.listId}) : super._() {
    if (id == null) throw new ArgumentError.notNull('id');
    if (name == null) throw new ArgumentError.notNull('name');
    if (completed == null) throw new ArgumentError.notNull('completed');
    if (listId == null) throw new ArgumentError.notNull('listId');
  }

  @override
  TaskModel rebuild(void updates(TaskModelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskModelBuilder toBuilder() => new TaskModelBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TaskModel) return false;
    return id == other.id &&
        name == other.name &&
        completed == other.completed &&
        listId == other.listId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), name.hashCode), completed.hashCode),
        listId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskModel')
          ..add('id', id)
          ..add('name', name)
          ..add('completed', completed)
          ..add('listId', listId))
        .toString();
  }
}

class TaskModelBuilder implements Builder<TaskModel, TaskModelBuilder> {
  _$TaskModel _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _completed;
  bool get completed => _$this._completed;
  set completed(bool completed) => _$this._completed = completed;

  String _listId;
  String get listId => _$this._listId;
  set listId(String listId) => _$this._listId = listId;

  TaskModelBuilder();

  TaskModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _completed = _$v.completed;
      _listId = _$v.listId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskModel other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$TaskModel;
  }

  @override
  void update(void updates(TaskModelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskModel build() {
    final _$result = _$v ??
        new _$TaskModel._(
            id: id, name: name, completed: completed, listId: listId);
    replace(_$result);
    return _$result;
  }
}

class _$ListModel extends ListModel {
  @override
  final String id;
  @override
  final String name;

  factory _$ListModel([void updates(ListModelBuilder b)]) =>
      (new ListModelBuilder()..update(updates)).build();

  _$ListModel._({this.id, this.name}) : super._() {
    if (id == null) throw new ArgumentError.notNull('id');
    if (name == null) throw new ArgumentError.notNull('name');
  }

  @override
  ListModel rebuild(void updates(ListModelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ListModelBuilder toBuilder() => new ListModelBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ListModel) return false;
    return id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListModel')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class ListModelBuilder implements Builder<ListModel, ListModelBuilder> {
  _$ListModel _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ListModelBuilder();

  ListModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListModel other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ListModel;
  }

  @override
  void update(void updates(ListModelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ListModel build() {
    final _$result = _$v ?? new _$ListModel._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

class _$UserModel extends UserModel {
  @override
  final String uid;
  @override
  final String email;
  @override
  final String displayName;

  factory _$UserModel([void updates(UserModelBuilder b)]) =>
      (new UserModelBuilder()..update(updates)).build();

  _$UserModel._({this.uid, this.email, this.displayName}) : super._() {
    if (email == null) throw new ArgumentError.notNull('email');
  }

  @override
  UserModel rebuild(void updates(UserModelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! UserModel) return false;
    return uid == other.uid &&
        email == other.email &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, uid.hashCode), email.hashCode), displayName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserModel')
          ..add('uid', uid)
          ..add('email', email)
          ..add('displayName', displayName))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel _$v;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  UserModelBuilder();

  UserModelBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _email = _$v.email;
      _displayName = _$v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserModel other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$UserModel;
  }

  @override
  void update(void updates(UserModelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserModel build() {
    final _$result = _$v ??
        new _$UserModel._(uid: uid, email: email, displayName: displayName);
    replace(_$result);
    return _$result;
  }
}
