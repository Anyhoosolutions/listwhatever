import 'package:core_models/core_models.dart';

abstract class ListItemsRepository {
  Future<ListItem?> getById({required String listId, required String itemId});

  Future<List<ListItem>> listByListId(String listId);

  Future<ListItem> create({required String listId, required ListItem item});

  Future<ListItem> update({required String listId, required ListItem item});

  Future<void> delete({required String listId, required String itemId});
}
