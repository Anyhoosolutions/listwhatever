import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';

abstract class AppRepositories {
  ItemsRepository get itemsRepository;

  CurrentTimeRepository get currentTimeRepository => CurrentTimeRepository(DateTime.now());
}
