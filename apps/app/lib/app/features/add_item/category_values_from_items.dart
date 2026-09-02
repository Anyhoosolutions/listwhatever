import 'package:core_models/core_models.dart';

Map<String, List<String>> categoryValuesFromItems(Iterable<ListItem> items) {
  final valuesByCategory = <String, Set<String>>{};

  for (final item in items) {
    item.categoryValues.forEach((key, values) {
      final category = key.trim();
      if (category.isEmpty) {
        return;
      }
      valuesByCategory.putIfAbsent(category, () => <String>{}).addAll(values);
    });
  }

  return {
    for (final entry in valuesByCategory.entries) entry.key: (entry.value.toList()..sort()),
  };
}
