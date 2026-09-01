import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';

import 'package:core_models/core_models.dart';

class FirestoreItemsRepository implements ItemsRepository {
  FirestoreItemsRepository({required FirestoreService firestoreService}) : _firestore = firestoreService.firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<Item?> getById(String id) async {
    final doc = await _firestore.collection('items').doc(id).get();
    if (!doc.exists) return null;
    return _fromDoc(doc);
  }

  @override
  Future<List<Item>> listAll() async {
    final snapshot = await _firestore.collection('items').get();
    return snapshot.docs.map(_fromDoc).toList();
  }

  Item _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Item(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
    );
  }
}
