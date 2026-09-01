import 'package:flutter_test/flutter_test.dart';
import 'package:lowercase_app_name/app/features/items/cubit/item_cubit.dart';
import 'package:lowercase_app_name/app/main/environments/fake/fake_repositories.dart';

void main() {
  test('ItemCubit loads fake item', () async {
    final cubit = ItemCubit(repository: FakeRepositories().itemsRepository);
    await cubit.load('1');

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.data?.id, '1');
    expect(cubit.state.data?.title, 'Sample item');
  });

  test('ItemCubit reports missing item', () async {
    final cubit = ItemCubit(repository: FakeRepositories().itemsRepository);
    await cubit.load('missing');

    expect(cubit.state.errorMessage, 'Item not found');
  });
}
