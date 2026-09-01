import 'package:lowercase_app_name/i18n/strings.g.dart';

extension TranslationsExtension on Translations {
  /// Joins [items] with locale-appropriate conjunctions and separators.
  ///
  /// English: "A and B", "A, B, and C"
  /// Swedish: "A och B", "A, B och C"
  String formatList(Iterable<String> items) {
    final parts = items.where((item) => item.isNotEmpty).toList();
    if (parts.isEmpty) {
      return '';
    }
    if (parts.length == 1) {
      return parts.first;
    }

    final conjunction = listConjunction;
    if (parts.length == 2) {
      return '${parts[0]} $conjunction ${parts[1]}';
    }

    final head = parts.sublist(0, parts.length - 1).join(', ');
    final tail = parts.last;
    return switch ($meta.locale) {
      AppLocale.en => '$head, $conjunction $tail',
      AppLocale.sv => '$head $conjunction $tail',
    };
  }
}
