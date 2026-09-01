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
  itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
  hasLocations: json['hasLocations'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  icon: $enumDecodeNullable(_$ListItemIconEnumMap, json['icon']) ?? null,
  iconBackground:
      $enumDecodeNullable(
        _$ListItemIconBackgroundEnumMap,
        json['iconBackground'],
      ) ??
      null,
);

Map<String, dynamic> _$DynamicListToJson(
  _DynamicList instance,
) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'title': instance.title,
  'description': instance.description,
  'visibility': instance.visibility,
  'collaboratorIds': instance.collaboratorIds,
  'itemCount': instance.itemCount,
  'hasLocations': instance.hasLocations,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'icon': _$ListItemIconEnumMap[instance.icon],
  'iconBackground': _$ListItemIconBackgroundEnumMap[instance.iconBackground],
};

const _$ListItemIconEnumMap = {
  ListItemIcon.movie: 'movie',
  ListItemIcon.restaurant: 'restaurant',
  ListItemIcon.hotel: 'hotel',
  ListItemIcon.flight: 'flight',
  ListItemIcon.car: 'car',
  ListItemIcon.train: 'train',
  ListItemIcon.bus: 'bus',
  ListItemIcon.flag: 'flag',
  ListItemIcon.park: 'park',
  ListItemIcon.golfCourse: 'golfCourse',
  ListItemIcon.eco: 'eco',
  ListItemIcon.waves: 'waves',
};

const _$ListItemIconBackgroundEnumMap = {
  ListItemIconBackground.red: 'red',
  ListItemIconBackground.green: 'green',
  ListItemIconBackground.blue: 'blue',
  ListItemIconBackground.yellow: 'yellow',
  ListItemIconBackground.purple: 'purple',
};
