import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:listwhatever/app/features/list_items/fake_list_items_repository.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';
import 'package:listwhatever/app/features/lists/fake_dynamic_lists_repository.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';

class FakeRepositories extends AppRepositories {
  FakeRepositories();

  static final _fixedNow = DateTime(2026, 1, 15, 12);

  @override
  DynamicListsRepository get dynamicListsRepository => FakeDynamicListsRepository();

  @override
  ListItemsRepository get listItemsRepository => FakeListItemsRepository();

  @override
  CurrentTimeRepository get currentTimeRepository => CurrentTimeRepository(_fixedNow);
}
