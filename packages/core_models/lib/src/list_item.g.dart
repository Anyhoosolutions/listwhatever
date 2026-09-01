// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListItem _$ListItemFromJson(Map<String, dynamic> json) => _ListItem(
  id: json['id'] as String,
  title: json['title'] as String,
  notes: json['notes'] as String,
  categoryValues: json['categoryValues'] as Map<String, dynamic>,
  address: json['address'] as String?,
  langlong: json['langlong'] == null
      ? null
      : LatLong.fromJson(json['langlong'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  icon: $enumDecodeNullable(_$ListItemIconEnumMap, json['icon']),
  iconBackground: $enumDecodeNullable(
    _$ListItemIconBackgroundEnumMap,
    json['iconBackground'],
  ),
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ListItemToJson(_ListItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'notes': instance.notes,
  'categoryValues': instance.categoryValues,
  'address': instance.address,
  'langlong': instance.langlong,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'icon': _$ListItemIconEnumMap[instance.icon],
  'iconBackground': _$ListItemIconBackgroundEnumMap[instance.iconBackground],
  'imageUrl': instance.imageUrl,
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
