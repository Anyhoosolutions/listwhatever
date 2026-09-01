import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';

class FirestoreListItemsRepository implements ListItemsRepository {
  FirestoreListItemsRepository({required FirestoreService firestoreService}) : _firestore = firestoreService.firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _items(String listId) {
    return _firestore.collection('lists').doc(listId).collection('items');
  }

  @override
  Future<ListItem?> getById({required String listId, required String itemId}) async {
    final doc = await _items(listId).doc(itemId).get();
    if (!doc.exists) return null;
    return _fromDoc(doc);
  }

  @override
  Future<List<ListItem>> listByListId(String listId) async {
    final snapshot = await _items(listId).get();
    return snapshot.docs.map(_fromDoc).toList();
  }

  @override
  Future<ListItem> create({required String listId, required ListItem item}) async {
    await _items(listId).doc(item.id).set(_toMap(item));
    return item;
  }

  @override
  Future<ListItem> update({required String listId, required ListItem item}) async {
    final updated = item.copyWith(updatedAt: DateTime.now().toUtc());
    await _items(listId).doc(item.id).set(_toMap(updated));
    return updated;
  }

  @override
  Future<void> delete({required String listId, required String itemId}) async {
    await _items(listId).doc(itemId).delete();
  }

  ListItem _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final categoryValues = data['categoryValues'];
    final langlong = data['langlong'];
    return ListItem(
      id: doc.id,
      title: data['title'] as String? ?? '',
      notes: data['notes'] as String? ?? '',
      categoryValues: categoryValues is Map<String, dynamic>
          ? categoryValues
          : Map<String, dynamic>.from(categoryValues as Map? ?? {}),
      address: data['address'] as String?,
      langlong: _latLong(langlong),
      createdAt: _date(data['createdAt']),
      updatedAt: _date(data['updatedAt']),
      icon: _icon(data['icon'] as String?),
      iconBackground: _iconBackground(data['iconBackground'] as String?),
      imageUrl: data['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> _toMap(ListItem item) {
    return {
      'title': item.title,
      'notes': item.notes,
      'categoryValues': item.categoryValues,
      'address': item.address,
      'langlong': item.langlong == null
          ? null
          : GeoPoint(item.langlong!.latitude, item.langlong!.longitude),
      'createdAt': Timestamp.fromDate(item.createdAt),
      'updatedAt': Timestamp.fromDate(item.updatedAt),
      'icon': item.icon?.name,
      'iconBackground': item.iconBackground?.name,
      'imageUrl': item.imageUrl,
    };
  }

  DateTime _date(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.parse(value);
    return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  }

  LatLong? _latLong(dynamic value) {
    if (value is GeoPoint) {
      return LatLong(latitude: value.latitude, longitude: value.longitude);
    }
    if (value is Map<String, dynamic>) {
      return LatLong.fromJson(value);
    }
    return null;
  }

  ListItemIcon? _icon(String? name) {
    if (name == null) return null;
    for (final value in ListItemIcon.values) {
      if (value.name == name) return value;
    }
    return null;
  }

  ListItemIconBackground? _iconBackground(String? name) {
    if (name == null) return null;
    for (final value in ListItemIconBackground.values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
