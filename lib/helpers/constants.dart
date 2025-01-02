import 'dart:math';

enum Side {
  left._('left'),
  right._('rights');

  const Side._(this.value);

  final String value;
}

Iterable<(int, T)> mapIndexed<T>(
  Iterable<T> items,
) sync* {
  var index = 0;

  for (final item in items) {
    yield (index, item);
    index = index + 1;
  }
}

class Constants {
  static const _chars = 'AaBbCcDdEeFfGgHhiJjKkLMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
        ),
      );

  static DateTime minDate = DateTime.parse('1970-01-01');
  static DateTime maxDate = DateTime.parse('2040-01-01');

  static double maxDistance = 1000000;
}
