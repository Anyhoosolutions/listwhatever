import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart';

const _sizes = [16, 32, 64, 128, 256, 512, 1024];

const _contentsJson = '''
{
  "images": [
    {"size": "16x16", "idiom": "mac", "filename": "app_icon_16.png", "scale": "1x"},
    {"size": "16x16", "idiom": "mac", "filename": "app_icon_32.png", "scale": "2x"},
    {"size": "32x32", "idiom": "mac", "filename": "app_icon_32.png", "scale": "1x"},
    {"size": "32x32", "idiom": "mac", "filename": "app_icon_64.png", "scale": "2x"},
    {"size": "128x128", "idiom": "mac", "filename": "app_icon_128.png", "scale": "1x"},
    {"size": "128x128", "idiom": "mac", "filename": "app_icon_256.png", "scale": "2x"},
    {"size": "256x256", "idiom": "mac", "filename": "app_icon_256.png", "scale": "1x"},
    {"size": "256x256", "idiom": "mac", "filename": "app_icon_512.png", "scale": "2x"},
    {"size": "512x512", "idiom": "mac", "filename": "app_icon_512.png", "scale": "1x"},
    {"size": "512x512", "idiom": "mac", "filename": "app_icon_1024.png", "scale": "2x"}
  ],
  "info": {"version": 1, "author": "xcode"}
}
''';

void main() {
  _generateIconSet('AppIcon-prod', 'assets/icons/icon_prod.png');
  _generateIconSet('AppIcon-staging', 'assets/icons/icon_staging.png');
  _generateIconSet('AppIcon', 'assets/icons/icon_prod.png');
  stdout.writeln('macOS launcher icons generated.');
}

void _generateIconSet(String setName, String sourcePath) {
  final sourceFile = File(sourcePath);
  if (!sourceFile.existsSync()) {
    stderr.writeln('Missing source image: $sourcePath');
    exit(1);
  }

  final source = decodeImage(sourceFile.readAsBytesSync());
  if (source == null) {
    stderr.writeln('Failed to decode: $sourcePath');
    exit(1);
  }

  final outDir = Directory(
    'macos/Runner/Assets.xcassets/$setName.appiconset',
  );
  outDir.createSync(recursive: true);
  File('${outDir.path}/Contents.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(jsonDecode(_contentsJson)),
  );

  for (final size in _sizes) {
    final icon = copyResize(
      source,
      width: size,
      height: size,
      interpolation: size >= 256 ? Interpolation.average : Interpolation.linear,
    );
    File('${outDir.path}/app_icon_$size.png').writeAsBytesSync(encodePng(icon));
  }

  stdout.writeln('Generated $setName from ${sourceFile.uri.pathSegments.last}');
}
