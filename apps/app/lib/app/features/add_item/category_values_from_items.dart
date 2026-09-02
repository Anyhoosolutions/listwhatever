import 'package:core_models/core_models.dart';

Map<String, List<String>> categoryValuesFromItems(Iterable<ListItem> items) {
  final valuesByCategory = <String, Set<String>>{};

  for (final item in items) {
    item.categoryValues.forEach((key, value) {
      final category = key.trim();
      if (category.isEmpty) {
        return;
      }
      final values = stringValues(value);
      if (values.isEmpty) {
        return;
      }
      valuesByCategory.putIfAbsent(category, () => <String>{}).addAll(values);
    });
  }

  return {
    for (final entry in valuesByCategory.entries) entry.key: (entry.value.toList()..sort()),
  };
}

List<String> stringValues(Object? value) {
  if (value == null) {
    return [];
  }
  if (value is Iterable) {
    return value.map((entry) => entry.toString().trim()).where((entry) => entry.isNotEmpty).toList();
  }
  final asString = value.toString().trim();
  return asString.isEmpty ? [] : [asString];
}
