import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';
import 'package:listwhatever/app/main/environments/fake/fake_items_repository.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';

class FakeRepositories extends AppRepositories {
  FakeRepositories();

  static final _fixedNow = DateTime(2026, 1, 15, 12);

  @override
  ItemsRepository get itemsRepository => FakeItemsRepository();

  @override
  CurrentTimeRepository get currentTimeRepository => CurrentTimeRepository(_fixedNow);
}
