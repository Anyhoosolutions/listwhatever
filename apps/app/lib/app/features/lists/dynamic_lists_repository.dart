import 'package:core_models/core_models.dart';

abstract class DynamicListsRepository {
  Future<DynamicList?> getById(String id);

  Future<List<DynamicList>> listAll();
}
