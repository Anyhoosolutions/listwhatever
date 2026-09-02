abstract final class AddItemFormFields {
  static const name = 'name';
  static const description = 'description';
  static const location = 'location';

  static String attributeKey(int id) => 'attributeKey_$id';
  static String attributeValue(int id) => 'attributeValue_$id';
}
