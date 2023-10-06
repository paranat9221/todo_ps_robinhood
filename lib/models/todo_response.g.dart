// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoResponseImpl _$$TodoResponseImplFromJson(Map<String, dynamic> json) =>
    _$TodoResponseImpl(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TodoTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'] as int,
      totalPages: json['totalPages'] as int,
    );

Map<String, dynamic> _$$TodoResponseImplToJson(_$TodoResponseImpl instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'pageNumber': instance.pageNumber,
      'totalPages': instance.totalPages,
    };
