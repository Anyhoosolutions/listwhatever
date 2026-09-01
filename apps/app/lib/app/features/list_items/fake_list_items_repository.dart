import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/list_items/list_item_preview.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';

class FakeListItemsRepository implements ListItemsRepository {
  FakeListItemsRepository({Map<String, List<ListItem>>? seed})
      : _itemsByListId = {
          for (final entry in (seed ?? _defaultItems).entries) entry.key: {for (final item in entry.value) item.id: item},
        };

  final Map<String, Map<String, ListItem>> _itemsByListId;

  static final _defaultItems = {
    'golf': ListItemsSampleData.golfCourses,
    'trips': ListItemsSampleData.golfCourses,
  };

  @override
  Future<ListItem?> getById({required String listId, required String itemId}) async {
    return _itemsByListId[listId]?[itemId];
  }

  @override
  Future<List<ListItem>> listByListId(String listId) async {
    final items = _itemsByListId[listId]?.values.toList() ?? [];
    return List.unmodifiable(items);
  }

  @override
  Future<ListItem> create({required String listId, required ListItem item}) async {
    final items = _itemsByListId.putIfAbsent(listId, () => {});
    if (items.containsKey(item.id)) {
      throw StateError('Item already exists: ${item.id}');
    }
    items[item.id] = item;
    return item;
  }

  @override
  Future<ListItem> update({required String listId, required ListItem item}) async {
    final items = _itemsByListId[listId];
    if (items == null || !items.containsKey(item.id)) {
      throw StateError('Item not found: ${item.id}');
    }
    final updated = item.copyWith(updatedAt: DateTime.now().toUtc());
    items[item.id] = updated;
    return updated;
  }

  @override
  Future<void> delete({required String listId, required String itemId}) async {
    final items = _itemsByListId[listId];
    if (items == null || !items.containsKey(itemId)) {
      throw StateError('Item not found: $itemId');
    }
    items.remove(itemId);
  }
}
