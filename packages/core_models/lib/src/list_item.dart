import 'package:core_models/src/lat_long.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

enum ListItemIcon {
  movie,
  restaurant,
  hotel,
  flight,
  car,
  train,
  bus,
  flag,
  park,
  golfCourse,
  eco,
  waves,
}

enum ListItemIconBackground {
  red,
  green,
  blue,
  yellow,
  purple,
}

@freezed
abstract class ListItem with _$ListItem {
  const factory ListItem({
    required String id,
    required String title,
    required String notes,
    required Map<String, dynamic> categoryValues, // Keys match CategoryDef.key
    String? address,
    LatLong? langlong,
    required DateTime createdAt,
    required DateTime updatedAt,
    ListItemIcon? icon,
    ListItemIconBackground? iconBackground,
    String? imageUrl,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
}
