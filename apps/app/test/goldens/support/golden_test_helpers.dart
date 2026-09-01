import 'package:alchemist/alchemist.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screenshot_kit/screenshot_kit.dart';

import 'golden_screenshot_presets.dart';

bool _usesScreenshotKitDefaultSize(ScreenshotSurfaceConfig config) {
  return config.logicalWidth == 390 && config.logicalHeight == 844 && config.devicePixelRatio == 1.0;
}

void appGoldenTest({
  required String description,
  required String fileName,
  required Widget child,
  String scenarioName = 'default',
  bool showScenarioLabel = false,
  PumpAction? pumpBeforeTest,

  /// When set, overrides [ScreenshotSurfaceConfig] width (e.g. wide dashboard layouts).
  double? surfaceWidth,

  /// When set, overrides [ScreenshotSurfaceConfig] height.
  double? surfaceHeight,
}) {
  final config = ScreenshotSurfaceConfig.fromEnvironment();
  final hubRegression = GoldenScreenshotPresets.hubRegression;
  final w =
      surfaceWidth ??
      (_usesScreenshotKitDefaultSize(config) ? hubRegression.width.toDouble() : config.logicalWidth.toDouble());
  final h =
      surfaceHeight ??
      (_usesScreenshotKitDefaultSize(config) ? hubRegression.height.toDouble() : config.logicalHeight.toDouble());

  goldenTest(
    description,
    fileName: fileName,
    pumpBeforeTest: pumpBeforeTest ?? _defaultPumpBeforeGolden,
    builder: () {
      final constrainedChild = SizedBox(width: w, height: h, child: child);

      if (!showScenarioLabel) {
        return constrainedChild;
      }

      return GoldenTestGroup(
        scenarioConstraints: BoxConstraints.tightFor(width: w, height: h),
        children: [GoldenTestScenario(name: scenarioName, child: child)],
      );
    },
  );
}

/// Shared default for hub goldens:
/// - load seeded projects
/// - precache asset/network images used by cards
/// - pump a few frames deterministically (avoid unbounded pumpAndSettle loops)
Future<void> _defaultPumpBeforeGolden(WidgetTester tester) async {
  await _precacheGoldenImages(tester);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 100));
}

/// Alchemist's [precacheImages] ends with [WidgetTester.pumpAndSettle], which
/// never completes while hub pages show loading spinners.
Future<void> _precacheGoldenImages(WidgetTester tester) async {
  await tester.runAsync(() async {
    final images = <Future<void>>[];
    for (final element in find.byType(Image).evaluate()) {
      final widget = element.widget as Image;
      images.add(precacheImage(widget.image, element));
    }
    for (final element in find.byType(FadeInImage).evaluate()) {
      final widget = element.widget as FadeInImage;
      images.add(precacheImage(widget.image, element));
    }
    for (final element in find.byType(DecoratedBox).evaluate()) {
      final widget = element.widget as DecoratedBox;
      final decoration = widget.decoration;
      if (decoration is BoxDecoration && decoration.image != null) {
        images.add(precacheImage(decoration.image!.image, element));
      }
    }
    await Future.wait(images);
  });
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 100));
}
