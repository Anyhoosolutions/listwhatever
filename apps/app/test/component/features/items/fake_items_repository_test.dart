@Tags(['component'])
library;

import 'package:listwhatever/app/main/environments/fake/fake_items_repository.dart';
import 'package:listwhatever/app/main/environments/fake/fake_repositories.dart';
import 'package:test/test.dart';

void main() {
  group('FakeItemsRepository', () {
    test('getById and listAll return consistent data', () async {
      final repo = FakeItemsRepository();
      final listed = await repo.listAll();
      final item = await repo.getById('1');

      expect(listed.length, 2);
      expect(item?.id, '1');
      expect(listed.first.id, item?.id);
    });

    test('returns null for unknown id', () async {
      expect(await FakeItemsRepository().getById('missing'), isNull);
    });
  });

  group('FakeRepositories', () {
    test('itemsRepository getter wires fake implementation', () async {
      final item = await FakeRepositories().itemsRepository.getById('2');
      expect(item?.title, 'Another item');
    });
  });
}
