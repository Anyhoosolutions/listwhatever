// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_with_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListWithItems _$ListWithItemsFromJson(Map<String, dynamic> json) =>
    _ListWithItems(
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
      items: (json['items'] as List<dynamic>)
          .map((e) => ListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$ListWithItemsToJson(
  _ListWithItems instance,
) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'title': instance.title,
  'description': instance.description,
  'visibility': instance.visibility,
  'collaboratorIds': instance.collaboratorIds,
  'items': instance.items,
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
  ListItemIconBackground.blue: 'blue',
  ListItemIconBackground.red: 'red',
  ListItemIconBackground.green: 'green',
  ListItemIconBackground.orange: 'orange',
  ListItemIconBackground.purple: 'purple',
  ListItemIconBackground.yellow: 'yellow',
  ListItemIconBackground.bronze: 'bronze',
  ListItemIconBackground.lightblue: 'lightblue',
  ListItemIconBackground.lightpurple: 'lightpurple',
  ListItemIconBackground.lightgreen: 'lightgreen',
  ListItemIconBackground.pink: 'pink',
};
