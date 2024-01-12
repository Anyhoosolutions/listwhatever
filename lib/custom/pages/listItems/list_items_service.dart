import 'package:cloud_firestore/cloud_firestore.dart';
import '/standard/constants.dart';
import '/standard/firebase/firestore/firestore.dart';

import '../../pages/listItems/list_item.dart';

class ListItemsService {
  ListItemsService({required this.userId});

  String? userId;

  // ignore: use_setters_to_change_properties
  void changeUser(String? userId) {
    this.userId = userId;
  }

  Future<CollectionReference<Map<String, dynamic>>> getCollection(String listId) async {
    final path = '/lists/$listId/items';
    logger.d('ListItemsService.path: $path');
    return (await getFirestore()).collection(path);
  }

  Stream<List<ListItem>> getListItems(String listId) async* {
    final itemsCollection = await getCollection(listId);

    yield* itemsCollection.snapshots().map((snapshot) {
      // logger.d('number of getListItems: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ListItem.fromJson(data);
      }).toList();
    });
  }

  Future<ListItem> getListItem(String listId, String itemId) async {
    // logger.d('getListItem($listId, $itemId)');
    final itemsCollection = await getCollection(listId);
    final snapshot = await itemsCollection.doc(itemId).get();
    final data = snapshot.data()!;
    return ListItem.fromJson(data);
  }

  Future<void> addListItem(String listId, ListItem list) async {
    final itemsCollection = await getCollection(listId);
    final docId = itemsCollection.doc().id;

    final updatedListItem = list.copyWith(
        id: docId,
        latestUpdateUser: userId,
    ).toJson();

    return itemsCollection.doc(docId).set(updatedListItem);
  }

  Future<void> updateListItem(String listId, ListItem listItem) async {
    final itemsCollection = await getCollection(listId);

    final updatedListItem = listItem.copyWith(
      latestUpdateUser: userId,
    ).toJson();

    return itemsCollection.doc(listItem.id).update(updatedListItem);
  }

  Future<void> deleteListItem(String listId, String itemId) async {
    final itemsCollection = await getCollection(listId);
    return itemsCollection.doc(itemId).delete();
  }
}