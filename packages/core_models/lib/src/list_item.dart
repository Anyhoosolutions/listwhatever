import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

@freezed
abstract class ListItem with _$ListItem {
  const factory ListItem({
    required String id,
    required String listId,
    required String title,
    required String notes,
    required Map<String, dynamic> categoryValues, // Keys match CategoryDef.key
    String? address,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
}
