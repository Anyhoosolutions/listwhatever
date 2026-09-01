import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';
import 'package:listwhatever/app/main/environments/prod/firestore_items_repository.dart';

class ProductionRepositories extends AppRepositories {
  ProductionRepositories({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  ItemsRepository get itemsRepository => FirestoreItemsRepository(firestoreService: firestoreService);
}
