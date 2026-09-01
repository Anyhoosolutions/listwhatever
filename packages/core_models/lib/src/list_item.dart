import 'package:core_models/src/item_icon_backgrounds.dart';
import 'package:core_models/src/item_icons.dart';
import 'package:core_models/src/lat_long.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

@freezed
abstract class ListItem with _$ListItem {
  const factory ListItem({
    required String id,
    required String title,
    @Default(null) String? notes,
    required Map<String, dynamic> categoryValues, // Keys match CategoryDef.key
    @Default(null) String? address,
    @Default(null) LatLong? latlong,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(null) ListItemIcon? icon,
    @Default(null) ListItemIconBackground? iconBackground,
    String? imageUrl,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
}
