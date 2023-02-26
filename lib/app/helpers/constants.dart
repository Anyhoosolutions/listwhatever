import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Iterable<MapEntry<int, T>> mapIndexed<T>(
  Iterable<T> items,
) sync* {
  var index = 0;

  for (final item in items) {
    yield MapEntry(index, item);
    index = index + 1;
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

DateTime getCurrentTime() {
  final now = DateTime.now();
  final date = DateTime(now.year, now.month, now.day);
  return date;
}

final dateFormatter = DateFormat('yyyy-MM-dd');
final timeFormatter = DateFormat('HH:mm');
final readableDateAndTimeFormatter = DateFormat('d MMM HH:mm');