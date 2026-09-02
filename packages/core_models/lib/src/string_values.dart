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
