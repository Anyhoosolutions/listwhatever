@Tags(['component'])
library;

import 'package:listwhatever/app/features/list_items/fake_list_items_repository.dart';
import 'package:listwhatever/app/main/environments/fake/fake_repositories.dart';
import 'package:test/test.dart';

void main() {
  group('FakeListItemsRepository', () {
    test('listByListId and getById return consistent golf items', () async {
      final repo = FakeListItemsRepository();
      final listed = await repo.listByListId('golf');
      final item = await repo.getById(listId: 'golf', itemId: 'pebble');

      expect(listed.length, 5);
      expect(item?.title, 'Pebble Beach Golf Links');
      expect(listed.first.id, item?.id);
    });

    test('returns null for unknown item', () async {
      expect(
        await FakeListItemsRepository().getById(listId: 'golf', itemId: 'missing'),
        isNull,
      );
    });
  });

  group('FakeRepositories', () {
    test('listItemsRepository getter wires fake implementation', () async {
      final item = await FakeRepositories().listItemsRepository.getById(
        listId: 'golf',
        itemId: 'augusta',
      );
      expect(item?.title, 'Augusta National');
    });
  });
}
