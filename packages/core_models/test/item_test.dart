import 'package:core_models/core_models.dart';
import 'package:test/test.dart';

void main() {
  group('Item', () {
    group('json', () {
      final item = Item(id: '1', title: 'Title', description: 'Description');

      test('toJson', () {
        expect(item.toJson(), {'id': '1', 'title': 'Title', 'description': 'Description'});
      });

      test('fromJson', () {
        expect(Item.fromJson({'id': '1', 'title': 'Title', 'description': 'Description'}), item);
      });
    });
  });
}
