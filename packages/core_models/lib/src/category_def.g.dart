// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_def.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryDef _$CategoryDefFromJson(Map<String, dynamic> json) => _CategoryDef(
  key: json['key'] as String,
  displayName: json['displayName'] as String,
  valueType: json['valueType'] as String,
  availableOptions:
      (json['availableOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$CategoryDefToJson(_CategoryDef instance) =>
    <String, dynamic>{
      'key': instance.key,
      'displayName': instance.displayName,
      'valueType': instance.valueType,
      'availableOptions': instance.availableOptions,
    };
