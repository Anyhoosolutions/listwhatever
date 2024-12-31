import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listwhatever/firestore/firestore.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';

class ListItemRepository {
  ListItemRepository();

  Future<CollectionReference<Map<String, dynamic>>> getCollection(
    String listId,
  ) async {
    final path = '/lists/$listId/items';
    print('ListRepository path: $path');
    return (await getFirestore()).collection(path);
  }

  Future<DocumentReference<Map<String, dynamic>>> getDocument(
    String listId,
    String itemId,
  ) async {
    final path = '/lists/$listId/items/$itemId';
    print('ListRepository path: $path');
    return (await getFirestore()).doc(path);
  }

  Future<List<ListItem>> loadListItems(String listId) async {
    final listsCollection = await getCollection(listId);

    final snapshot = await listsCollection.get();
    final docs = snapshot.docs;
    final listItems = <ListItem>[];
    for (final doc in docs) {
      listItems.add(convertToListItem(doc.id, doc.data()));
    }
    return listItems;
  }

  Future<ListItem> loadListItem(String listId, String itemId) async {
    final document = await getDocument(listId, itemId);

    final doc = await document.get();
    final item = convertToListItem(doc.id, doc.data()!);
    return item;
  }

  ListItem convertToListItem(String id, Map<String, dynamic> data) {
    final list = ListItem.fromJson(data);
    return list.copyWith(
      id: id,
    );
  }

  Future<String> addListItem(String listId, ListItem listItem) async {
    final listItemsCollection = await getCollection(listId);
    final ref = await listItemsCollection.add(listItem.toJson());
    return ref.id;
  }
}
