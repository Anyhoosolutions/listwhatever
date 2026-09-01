@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/home/home_page.dart';

import 'support/golden_screenshot_presets.dart';
import 'support/golden_test_helpers.dart';
import 'support/hub_golden_harness.dart';

void main() {
  appGoldenTest(
    description: 'Home Page laptop',
    fileName: 'home_page_laptop',
    surfaceWidth: GoldenScreenshotPresets.laptop.width.toDouble(),
    surfaceHeight: GoldenScreenshotPresets.laptop.height.toDouble(),
    child: _homePage(),
  );

  appGoldenTest(
    description: 'Home Page tablet landscape',
    fileName: 'home_page_tablet_landscape',
    surfaceWidth: GoldenScreenshotPresets.tabletLandscape.width.toDouble(),
    surfaceHeight: GoldenScreenshotPresets.tabletLandscape.height.toDouble(),
    child: _homePage(),
  );

  appGoldenTest(
    description: 'Home Page phone',
    fileName: 'home_page_phone',
    surfaceWidth: GoldenScreenshotPresets.phone.width.toDouble(),
    surfaceHeight: GoldenScreenshotPresets.phone.height.toDouble(),
    child: _homePage(),
  );
}

Widget _homePage() {
  return buildHubGoldenHarnessWithShell(
    shellPage: const HomePage(),
  );
}
