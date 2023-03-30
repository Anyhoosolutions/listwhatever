// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listanything/app/widgets/standardWidgets/custom_exception.dart';
import 'package:listanything/app/widgets/standardWidgets/error_monitor.dart';

abstract class BaseRepository<T> {
  Stream<List<T>> retrieveItemsStream();
  Stream<List<T>> retrieveItemsStreamAtPath(String path);
  Stream<T> retrieveItemStream({required String itemId});
  Stream<T> retrieveItemStreamAtPath(String path);
  Future<String> createItem({required T item});
  Future<String> updateItem({required String itemId, required T item});
  Future<void> deleteItem({required String itemId});
}

class BaseRepositoryImpl<T> implements BaseRepository<T> {
  BaseRepositoryImpl(
    this.firestore,
    this.errorMonitor,
    this.firestoreItemsPath,
    this.firestoreItemPath,
    this.identifiers,
    this.itemConverter,
    this.jsonFunction,
  ) {
    // if (identifiers.values.take(identifiers.length - 1).any((i) => i == null)) {
    //   throw CustomException(
    //     message:
    //         'Some identifiers are not set: ${identifiers.entries.where((e) => e.value == null).map((e) => e.key).join(', ')}',
    //   );
    // }
  }

  final ErrorMonitor errorMonitor;
  final FirebaseFirestore firestore;
  final Map<String, String?> identifiers;
  final CollectionReference<Map<String, dynamic>> Function(Map<String, String?>) firestoreItemsPath;
  final DocumentReference<Map<String, dynamic>> Function(Map<String, String?>) firestoreItemPath;
  final T Function(Map<String, dynamic>, String) itemConverter;
  final Map<String, dynamic> Function(T) jsonFunction;

  @override
  Stream<List<T>> retrieveItemsStream() async* {
    try {
      if (identifiers.values.any((element) => element == null)) {
        throw CustomException(message: 'Some null items $identifiers');
      }
      final query = firestoreItemsPath(identifiers);
      yield* query.snapshots().map(convertCollection);
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<List<T>> retrieveItemsStreamAtPath(String path) async* {
    try {
      yield* firestore.collection(path).snapshots().map(convertCollection);
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<T> retrieveItemStream({required String itemId}) async* {
    try {
      final query = firestoreItemPath({...identifiers, 'itemId': itemId});
      yield* query.snapshots().where((snapshot) => snapshot.data() != null).map(convertDocument);
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<T> retrieveItemStreamAtPath(String path) async* {
    try {
      yield* firestore.doc(path).snapshots().where((snapshot) => snapshot.data() != null).map(convertDocument);
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  T convertDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    try {
      final item = itemConverter(doc.data()!, doc.id);
      return item;
    } on FirebaseException catch (e, s) {
      errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      print('error: e');
      throw CustomException(message: e.message);
    }
  }

  List<T> convertCollection(QuerySnapshot<Map<String, dynamic>> list) {
    try {
      final items = list.docs.map((d) {
        // final item = ListItem.fromJson(d.data()).copyWith(id: d.id);
        final item = itemConverter(d.data(), d.id);
        return item;
      }).toList();
      print('convertCollection.items: ${items.length}');
      return items;
    } on FirebaseException catch (e, s) {
      errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createItem({required T item}) async {
    try {
      final data = jsonFunction(item);
      print('data: $data');
      final ref = await firestoreItemsPath(identifiers).add(data);
      return ref.id;
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> updateItem({required String itemId, required T item}) async {
    try {
      await firestoreItemPath({...identifiers, 'itemId': itemId}).update(jsonFunction(item));
      return itemId;
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({required String itemId}) async {
    try {
      await firestoreItemPath({...identifiers, 'itemId': itemId}).delete();
    } on FirebaseException catch (e, s) {
      await errorMonitor.recordError(e, s, 'as an example of non-fatal error');
      throw CustomException(message: e.message);
    }
  }
}
