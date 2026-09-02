@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/home/pages/home_page.dart';

import 'support/golden_screenshot_presets.dart';
import 'support/golden_test_helpers.dart';
import 'support/hub_golden_harness.dart';

void main() {
  const devices = [
    (
      name: 'phone',
      preset: GoldenScreenshotPresets.phone,
    ),
    // (
    //   name: 'tablet_landscape',
    //   preset: GoldenScreenshotPresets.tabletLandscape,
    // ),
    // (
    //   name: 'laptop',
    //   preset: GoldenScreenshotPresets.laptop,
    // ),
  ];

  for (final themeMode in [
    ThemeMode.light /* ThemeMode.dark*/,
  ]) {
    final themeName = themeMode == ThemeMode.dark ? 'dark' : 'light';
    for (final device in devices) {
      appGoldenTest(
        description: 'Home Page ${device.name} $themeName',
        fileName: 'home_page_${device.name}_$themeName',
        surfaceWidth: device.preset.width.toDouble(),
        surfaceHeight: device.preset.height.toDouble(),
        child: buildHubGoldenHarnessWithShell(
          themeMode: themeMode,
          shellPage: const HomePage(),
        ),
      );
    }
  }
}
