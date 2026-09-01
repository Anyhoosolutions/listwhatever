import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';

abstract class AppRepositories {
  ItemsRepository get itemsRepository;

  DynamicListsRepository get dynamicListsRepository;

  ListItemsRepository get listItemsRepository;

  CurrentTimeRepository get currentTimeRepository => CurrentTimeRepository(DateTime.now());
}
