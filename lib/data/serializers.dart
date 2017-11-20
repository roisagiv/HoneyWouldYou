library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:honeywouldyou/data/models.dart';

part 'serializers.g.dart';

///
@SerializersFor(const <Type>[ListModel, TaskModel])
final Serializers serializers = _$serializers;
