import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';

class FakeDynamicListsRepository implements DynamicListsRepository {
  FakeDynamicListsRepository({List<DynamicList>? seed})
      : _lists = {
          for (final list in seed ?? _defaultLists) list.id: list,
        };

  final Map<String, DynamicList> _lists;

  static final _now = DateTime.utc(2026, 9, 1, 17);

  static final _defaultLists = [
    DynamicList(
      id: 'movies',
      ownerId: 'user-1',
      title: 'Movies to Watch',
      description: 'Personal watchlist',
      visibility: 'private',
      createdAt: _now.subtract(const Duration(days: 14)),
      updatedAt: _now.subtract(const Duration(hours: 2)),
    ),
    DynamicList(
      id: 'golf',
      ownerId: 'user-1',
      title: 'Golf Courses',
      description: 'Courses to play',
      visibility: 'private',
      createdAt: _now.subtract(const Duration(days: 30)),
      updatedAt: _now.subtract(const Duration(days: 1)),
    ),
    DynamicList(
      id: 'groceries',
      ownerId: 'user-1',
      title: 'Groceries',
      description: 'Weekly shopping',
      visibility: 'private',
      createdAt: _now.subtract(const Duration(days: 7)),
      updatedAt: _now.subtract(const Duration(hours: 4)),
    ),
    DynamicList(
      id: 'trips',
      ownerId: 'user-1',
      title: 'Dream Trips',
      description: 'Places to go',
      visibility: 'private',
      createdAt: _now.subtract(const Duration(days: 60)),
      updatedAt: _now.subtract(const Duration(days: 7)),
    ),
  ];

  @override
  Future<DynamicList?> getById(String id) async => _lists[id];

  @override
  Future<List<DynamicList>> listAll() async => List.unmodifiable(_lists.values);
}
