/// Logical viewport presets for golden screenshot catalog runs.
///
/// Matches the dev-console golden import dialog and
/// [tool/golden_screenshot_catalog.py].
abstract final class GoldenScreenshotPresets {
  static const phone = (width: 390, height: 844);
  static const tablet = (width: 834, height: 1194);
  static const tabletLandscape = (width: 1194, height: 834);
  static const laptop = (width: 1680, height: 1050);

  /// Hub page goldens use a wide layout when no `SCREENSHOT_LOGICAL_*` defines
  /// are passed (see [appGoldenTest]).
  static const hubRegression = laptop;
}
