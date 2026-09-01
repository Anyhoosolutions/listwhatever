// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListItem _$ListItemFromJson(Map<String, dynamic> json) => _ListItem(
  id: json['id'] as String,
  listId: json['listId'] as String,
  title: json['title'] as String,
  notes: json['notes'] as String,
  categoryValues: json['categoryValues'] as Map<String, dynamic>,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ListItemToJson(_ListItem instance) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'title': instance.title,
  'notes': instance.notes,
  'categoryValues': instance.categoryValues,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
