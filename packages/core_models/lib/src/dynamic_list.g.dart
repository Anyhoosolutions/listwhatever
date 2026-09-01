// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DynamicList _$DynamicListFromJson(Map<String, dynamic> json) => _DynamicList(
  id: json['id'] as String,
  ownerId: json['ownerId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  visibility: json['visibility'] as String,
  collaboratorIds:
      (json['collaboratorIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryDef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DynamicListToJson(_DynamicList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'title': instance.title,
      'description': instance.description,
      'visibility': instance.visibility,
      'collaboratorIds': instance.collaboratorIds,
      'categories': instance.categories,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
