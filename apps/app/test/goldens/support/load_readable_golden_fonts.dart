import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads Roboto as Inter / Oswald / Roboto so golden tests render real glyphs
/// instead of the Flutter test font's solid blocks.
Future<void> loadReadableGoldenFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final regular = _fontBytes('Roboto-Regular.ttf');
  final medium = _fontBytes('Roboto-Medium.ttf');
  final bold = _fontBytes('Roboto-Bold.ttf');

  for (final family in ['Inter', 'Oswald', 'Roboto']) {
    final loader = FontLoader(family);
    loader.addFont(regular);
    loader.addFont(medium);
    loader.addFont(bold);
    await loader.load();
  }
}

Future<ByteData> _fontBytes(String fileName) async {
  final file = File('test/goldens/support/fonts/$fileName');
  final bytes = await file.readAsBytes();
  return ByteData.sublistView(Uint8List.fromList(bytes));
}
