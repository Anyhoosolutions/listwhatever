import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:listwhatever/app/features/geocoding/fake_geocoding_repository.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_repository.dart';
import 'package:listwhatever/app/features/list_items/repositories/list_items_repository.dart';
import 'package:listwhatever/app/features/lists/repositories/dynamic_lists_repository.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';
import 'package:listwhatever/app/features/lists/repositories/firestore_dynamic_lists_repository.dart';
import 'package:listwhatever/app/features/list_items/repositories/firestore_list_items_repository.dart';

class ProductionRepositories extends AppRepositories {
  ProductionRepositories({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  DynamicListsRepository get dynamicListsRepository =>
      FirestoreDynamicListsRepository(firestoreService: firestoreService);

  @override
  ListItemsRepository get listItemsRepository => FirestoreListItemsRepository(firestoreService: firestoreService);

  @override
  GeocodingRepository get geocodingRepository => FakeGeocodingRepository();
}
