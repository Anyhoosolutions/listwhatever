import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';

class FirestoreListItemsRepository implements ListItemsRepository {
  FirestoreListItemsRepository({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  Future<ListItem?> getById({required String listId, required String itemId}) async {
    final doc = await firestoreService.getDocument('lists/$listId/items/$itemId');
    if (doc == null) return null;
    return ListItem.fromJson(doc);
  }

  @override
  Future<List<ListItem>> listByListId(String listId) async {
    final snapshot = await firestoreService.getCollection('lists/$listId/items');
    return snapshot.map(ListItem.fromJson).toList();
  }

  @override
  Future<ListItem> create({required String listId, required ListItem item}) async {
    final json = item.toJson();
    print('create: $json');
    await firestoreService.addDocument(
      path: 'lists/$listId/items',
      data: json,
    );
    return item;
  }

  @override
  Future<ListItem> update({required String listId, required ListItem item}) async {
    final updated = item.copyWith(updatedAt: DateTime.now().toUtc());
    await firestoreService.updateDocument(
      'lists/$listId/items/${item.id}',
      item.id,
      updated.toJson(),
    );
    return updated;
  }

  @override
  Future<void> delete({required String listId, required String itemId}) async {
    await firestoreService.deleteDocument('lists/$listId/items/', itemId);
  }
}
