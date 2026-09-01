import 'package:core_models/core_models.dart';

abstract class ItemsRepository {
  Future<Item?> getById(String id);

  Future<List<Item>> listAll();
}
