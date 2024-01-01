import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:allmylists/custom/firestore/sharedList/shared_list.dart';
import 'package:allmylists/standard/firebase/firestore/firestore.dart';

class SharedListsService {
  SharedListsService();

  Future<CollectionReference<Map<String, dynamic>>> getCollection() async {
    const path = '/sharedLists';
    // logger.d('path: $path');
    return (await getFirestore()).collection(path);
  }

  Future<SharedList> getSharedList(String id) async {
    final sharedListsCollection = await getCollection();
    final snapshot = await sharedListsCollection.doc(id).get();
    final data = snapshot.data()!;
    return SharedList.fromJson(data).copyWith(id: snapshot.id);
  }

  Future<void> addUser(String id, String userId) async {
    final sharedListsCollection = await getCollection();
     return sharedListsCollection.doc(id).collection('users').doc(userId).set({'userId': userId});
  }

  // TODO:
  // Future<void> deleteSharedList(String sharedListId) async {
  //   final sharedListsCollection = await getCollection();
  //   return sharedListsCollection.doc(sharedListId).delete();
  // }
}
