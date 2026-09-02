import 'package:core_models/src/item_icon_backgrounds.dart';
import 'package:core_models/src/item_icons.dart';
import 'package:core_models/src/list_item.dart';
import 'package:core_models/src/typedefs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_with_items.freezed.dart';
part 'list_with_items.g.dart';

@freezed
abstract class ListWithItems with _$ListWithItems {
  const factory ListWithItems({
    required String id,
    required String ownerId,
    required String title,
    required String description,
    required String visibility, // 'private' | 'shared' | 'public'
    @Default([]) List<UserId> collaboratorIds,
    required List<ListItem> items,
    @Default(false) bool hasLocations,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(null) ListItemIcon? icon,
    @Default(null) ListItemIconBackground? iconBackground,
  }) = _ListWithItems;

  factory ListWithItems.fromJson(Map<String, dynamic> json) => _$ListWithItemsFromJson(json);
}
