import 'package:meta/meta.dart';

///
@immutable
class ListModel {
  ///
  final String id;

  ///
  final String title;

  ///
  final List<TaskModel> tasks;

  ///
  const ListModel(this.id, this.title, this.tasks);

  ///
  factory ListModel.fromJson(json) => new ListModel(json['_id'], json['title'],
      json['tasks'].map((item) => new TaskModel.fromJson(item)).toList());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          tasks == other.tasks;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ tasks.hashCode;
}

///
@immutable
class TaskModel {
  ///
  final String id;

  ///
  final String name;

  ///
  const TaskModel(this.id, this.name);

  ///
  factory TaskModel.fromJson(json) => new TaskModel(json['_id'], json['name']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
