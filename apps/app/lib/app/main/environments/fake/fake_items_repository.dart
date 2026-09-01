import 'package:listwhatever/app/features/items/items_repository.dart';
import 'package:core_models/core_models.dart';

class FakeItemsRepository implements ItemsRepository {
  static final _items = <Item>[
    const Item(
      id: '1',
      title: 'Sample item',
      description: 'Loaded from FakeItemsRepository.',
    ),
    const Item(
      id: '2',
      title: 'Another item',
      description: 'Use main_fake.dart for local development.',
    ),
  ];

  @override
  Future<Item?> getById(String id) async {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Future<List<Item>> listAll() async => List.unmodifiable(_items);
}
