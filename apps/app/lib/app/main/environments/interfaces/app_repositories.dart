import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:lowercase_app_name/app/features/items/items_repository.dart';

abstract class AppRepositories {
  ItemsRepository get itemsRepository;

  CurrentTimeRepository get currentTimeRepository => CurrentTimeRepository(DateTime.now());
}
