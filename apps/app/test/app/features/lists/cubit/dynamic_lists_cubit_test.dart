import 'package:core_models/core_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_cubit.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';
import 'package:listwhatever/app/features/lists/fake_dynamic_lists_repository.dart';

void main() {
  DynamicList newList({
    String id = 'cafes',
    String title = 'Favorite Cafes',
  }) {
    final now = DateTime.utc(2026, 1, 1);
    return DynamicList(
      id: id,
      ownerId: 'user-1',
      title: title,
      description: 'Coffee spots',
      visibility: 'private',
      createdAt: now,
      updatedAt: now,
    );
  }

  test('load returns seeded lists', () async {
    final cubit = DynamicListsCubit(repository: FakeDynamicListsRepository());
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.data?.map((list) => list.id), ['movies', 'golf', 'groceries', 'trips']);
  });

  test('create appends a list', () async {
    final cubit = DynamicListsCubit(repository: FakeDynamicListsRepository());
    addTearDown(cubit.close);

    await cubit.load();
    await cubit.create(newList());

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.data?.map((list) => list.id), ['movies', 'golf', 'groceries', 'trips', 'cafes']);
  });

  test('update changes an existing list', () async {
    final cubit = DynamicListsCubit(repository: FakeDynamicListsRepository());
    addTearDown(cubit.close);

    await cubit.load();
    final movies = cubit.state.data!.firstWhere((list) => list.id == 'movies');
    await cubit.update(movies.copyWith(title: 'Movies I Have Watched'));

    expect(cubit.state.errorMessage, isNull);
    expect(
      cubit.state.data?.firstWhere((list) => list.id == 'movies').title,
      'Movies I Have Watched',
    );
  });

  test('delete removes a list', () async {
    final cubit = DynamicListsCubit(repository: FakeDynamicListsRepository());
    addTearDown(cubit.close);

    await cubit.load();
    await cubit.delete('movies');

    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.data?.map((list) => list.id), ['golf', 'groceries', 'trips']);
  });

  test('create reports duplicate id and keeps existing data', () async {
    final cubit = DynamicListsCubit(repository: FakeDynamicListsRepository());
    addTearDown(cubit.close);

    await cubit.load();
    await cubit.create(newList(id: 'movies', title: 'Duplicate'));

    expect(cubit.state.data?.length, 4);
    expect(cubit.state.errorMessage, contains('List already exists: movies'));
  });

  test('delete reports missing id and keeps existing data', () async {
    final cubit = DynamicListsCubit(repository: FakeDynamicListsRepository());
    addTearDown(cubit.close);

    await cubit.load();
    await cubit.delete('missing');

    expect(cubit.state.data?.length, 4);
    expect(cubit.state.errorMessage, contains('List not found: missing'));
  });

  test('load reports repository errors', () async {
    final cubit = DynamicListsCubit(repository: _ThrowingListsRepository());
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.data, isNull);
    expect(cubit.state.errorMessage, contains('unavailable'));
  });
}

class _ThrowingListsRepository implements DynamicListsRepository {
  @override
  Future<DynamicList> create(DynamicList list) async => throw UnimplementedError();

  @override
  Future<void> delete(String id) async => throw UnimplementedError();

  @override
  Future<DynamicList?> getById(String id) async => throw UnimplementedError();

  @override
  Future<List<DynamicList>> listAll() async => throw Exception('unavailable');

  @override
  Future<DynamicList> update(DynamicList list) async => throw UnimplementedError();
}
