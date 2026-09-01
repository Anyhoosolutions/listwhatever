import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';

class FirestoreDynamicListsRepository implements DynamicListsRepository {
  FirestoreDynamicListsRepository({required this._firestoreService});

  final FirestoreService _firestoreService;

  @override
  Future<DynamicList?> getById(String id) async {
    final doc = await _firestoreService.getDocument('lists/$id');
    if (doc == null) return null;
    return DynamicList.fromJson(doc);
  }

  @override
  Future<List<DynamicList>> listAll() async {
    final snapshot = await _firestoreService.getCollection('lists');
    return snapshot.map(DynamicList.fromJson).toList();
  }

  @override
  Future<DynamicList> create(DynamicList list) async {
    await _firestoreService.addDocument(path: 'lists/$list.id', data: list.toJson());
    return list;
  }

  @override
  Future<DynamicList> update(DynamicList list) async {
    final updated = list.copyWith(updatedAt: DateTime.now().toUtc());
    await _firestoreService.updateDocument('lists/$list.id', list.id, updated.toJson());
    return updated;
  }

  @override
  Future<void> delete(String id) async {
    await _firestoreService.deleteDocument('lists/$id');
  }
}
