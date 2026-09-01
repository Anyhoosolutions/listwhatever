import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';
import 'package:listwhatever/app/features/lists/fake_dynamic_lists_repository.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';
import 'package:listwhatever/app/main/environments/prod/firestore_items_repository.dart';
import 'package:listwhatever/app/main/environments/prod/firestore_list_items_repository.dart';

class ProductionRepositories extends AppRepositories {
  ProductionRepositories({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  ItemsRepository get itemsRepository => FirestoreItemsRepository(firestoreService: firestoreService);

  @override
  DynamicListsRepository get dynamicListsRepository => FakeDynamicListsRepository();

  @override
  ListItemsRepository get listItemsRepository =>
      FirestoreListItemsRepository(firestoreService: firestoreService);
}
