import 'package:core_models/core_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';
import 'package:listwhatever/app/features/list_items/repositories/fake_list_items_repository.dart';
import 'package:listwhatever/app/features/list_items/repositories/list_items_repository.dart';

void main() {
  test('load returns seeded items for a list', () async {
    final cubit = ListItemsCubit(repository: FakeListItemsRepository());
    addTearDown(cubit.close);

    await cubit.load('golf');

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.data?.map((item) => item.id), [
      'pebble',
      'cypress',
      'st-andrews',
      'augusta',
      'county-down',
    ]);
  });

  test('load returns an empty list when the list has no items', () async {
    final cubit = ListItemsCubit(repository: FakeListItemsRepository());
    addTearDown(cubit.close);

    await cubit.load('movies');

    expect(cubit.state.data, isEmpty);
  });

  test('load reports repository errors', () async {
    final cubit = ListItemsCubit(repository: _ThrowingItemsRepository());
    addTearDown(cubit.close);

    await cubit.load('golf');

    expect(cubit.state.data, isNull);
    expect(cubit.state.errorMessage, contains('unavailable'));
  });
}

class _ThrowingItemsRepository implements ListItemsRepository {
  @override
  Future<ListItem> create({required String listId, required ListItem item}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String listId, required String itemId}) async {
    throw UnimplementedError();
  }

  @override
  Future<ListItem?> getById({required String listId, required String itemId}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<ListItem>> listByListId(String listId) async => throw Exception('unavailable');

  @override
  Future<ListItem> update({required String listId, required ListItem item}) async {
    throw UnimplementedError();
  }
}
