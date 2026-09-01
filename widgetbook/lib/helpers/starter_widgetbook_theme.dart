import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/main/environments/prod/flavors/flavor_profiles.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook shell + preview themes — same [AppTheme] as the main app.
abstract final class StarterWidgetbookTheme {
  static Color get seedColor => FlavorProfiles.prod.primaryColor;

  static ThemeData get light => AnyhooTheme.light();

  static ThemeData get dark => AnyhooTheme.dark();

  static MaterialThemeAddon get themeAddon => MaterialThemeAddon(
    themes: [
      WidgetbookTheme(name: 'Light', data: light),
      WidgetbookTheme(name: 'Dark', data: dark),
    ],
  );
}
