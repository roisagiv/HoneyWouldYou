library models;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'models.g.dart';

///
abstract class TaskModel implements Built<TaskModel, TaskModelBuilder> {
  ///
  factory TaskModel([updates(TaskModelBuilder b)]) = _$TaskModel;

  ///
  factory TaskModel.fromMap(Map<String, dynamic> map) =>
      new TaskModel((TaskModelBuilder b) => b
        ..id = map['_id']
        ..name = map['name']
        ..completed = false);

  ///
  TaskModel._();

  ///
  String get id;

  ///
  String get name;

  ///
  bool get completed;

  ///
  static Serializer<TaskModel> get serializer => _$taskModelSerializer;
}

///
abstract class ListModel implements Built<ListModel, ListModelBuilder> {
  ///
  factory ListModel([updates(ListModelBuilder b)]) = _$ListModel;

  ///
  factory ListModel.fromMap(Map<String, dynamic> map) {
    final Iterable<ListModel> taskModels =
        map['tasks'].map((t) => new TaskModel.fromMap(t));
    final ListBuilder<TaskModel> tasks = new ListBuilder<TaskModel>(taskModels);
    return new ListModel((ListModelBuilder b) => b
      ..name = map['title']
      ..id = map['_id']
      ..tasks = tasks);
  }

  ///
  ListModel._();

  ///
  String get id;

  ///
  String get name;

  ///
  BuiltList<TaskModel> get tasks;

  ///
  static Serializer<ListModel> get serializer => _$listModelSerializer;
}

///
abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  ///
  factory UserModel([updates(UserModelBuilder b)]) = _$UserModel;

  ///
  UserModel._();

  ///
  @nullable
  String get uid;

  ///
  String get email;

  ///
  @nullable
  String get displayName;
}

///
class AuthenticationStatus extends EnumClass {
  ///
  static const AuthenticationStatus authenticated = _$authenticated;

  ///
  static const AuthenticationStatus notAuthenticated = _$notAuthenticated;

  ///
  static const AuthenticationStatus error = _$error;

  ///
  static const AuthenticationStatus inProgress = _$inProgress;

  ///
  static const AuthenticationStatus notDetemined = _$notDetemined;

  ///
  const AuthenticationStatus._(String name) : super(name);

  ///
  static BuiltSet<AuthenticationStatus> get values => _$values;

  ///
  static AuthenticationStatus valueOf(String name) => _$valueOf(name);
}