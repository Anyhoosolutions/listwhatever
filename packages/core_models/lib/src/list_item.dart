import 'package:core_models/src/item_icon_backgrounds.dart';
import 'package:core_models/src/item_icons.dart';
import 'package:core_models/src/string_values.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

class CategoryValuesConverter implements JsonConverter<Map<String, List<String>>, Object?> {
  const CategoryValuesConverter();

  @override
  Map<String, List<String>> fromJson(Object? json) {
    if (json is! Map) {
      return {};
    }
    return {
      for (final entry in json.entries) entry.key.toString(): stringValues(entry.value),
    };
  }

  @override
  Map<String, List<String>> toJson(Map<String, List<String>> object) => object;
}

@freezed
abstract class ListItem with _$ListItem {
  const factory ListItem({
    required String id,
    required String title,
    @Default(null) String? notes,
    @CategoryValuesConverter() required Map<String, List<String>> categoryValues,
    @Default(null) String? address,
    @Default(null) Map<String, double>? latlong,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(null) ListItemIcon? icon,
    @Default(null) ListItemIconBackground? iconBackground,
    String? imageUrl,
  }) = _ListItem;

  const ListItem._();

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);

  String? firstCategoryValue(String key) {
    final values = categoryValues[key];
    if (values == null || values.isEmpty) {
      return null;
    }
    return values.first;
  }

  double? firstCategoryNumber(String key) {
    return double.tryParse(firstCategoryValue(key) ?? '');
  }
}
