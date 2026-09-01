import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => _withNavigationBar(AnyhooTheme.light(colors: _getLightColors()), _getLightColors());
  static ThemeData get dark => _withNavigationBar(AnyhooTheme.dark(colors: _getDarkColors()), _getDarkColors());

  static ThemeData _withNavigationBar(ThemeData theme, AppColors colors) {
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        surface: colors.surface.scaffoldBackground,
        surfaceContainer: colors.appBar.bottomBarBackground,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.appBar.bottomBarBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 56,
        indicatorColor: colors.surface.containerHigh,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colors.accent.primaryFixed : colors.appBar.bottomBarIconColors,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            color: selected ? colors.accent.primaryFixed : colors.appBar.bottomBarIconColors,
          );
        }),
      ),
    );
  }

  /// Slate surfaces with a sky-blue accent (from the design system guide).
  static AppColors _getLightColors() => AppColors(
    accent: AccentColors(
      primaryFixed: Colors.pink, // Color(0xFF0284C7),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryDisabled: Color(0xFFBAE6FD),
      onPrimaryDisabled: Color(0xFF0369A1),
      primaryContainer: Color(0xFFE0F2FE),
      onPrimaryContainer: Color(0xFF0369A1),
      headline: Color(0xFF0F172A),
      inversePrimary: Color(0xFF7DD3FC),
    ),
    surface: SurfaceColors(
      scaffoldBackground: Color(0xFFF8FAFC),
      lowContrastBackground: Color(0xFFF1F5F9),
      primaryText: Color(0xFF0F172A),
      secondaryText: Color(0xFF475569),
      cardBackground: Color(0xFFFFFFFF),
      cardBorder: Color(0xFFE2E8F0),
      containerHigh: Color(0xFFE2E8F0),
      containerLow: Color(0xFFF1F5F9),
      containerHighest: Color(0xFFCBD5E1),
      containerLowest: Color(0xFFFFFFFF),
      outline: Color(0xFF94A3B8),
      secondaryContainer: Color(0xFFE0F2FE),
      onSecondaryContainer: Color(0xFF0369A1),
      inverseSurface: Color(0xFF1E293B),
      inverseOnSurface: Color(0xFFF8FAFC),
    ),
    appBar: AppBarColors(
      topBarBackground: Color(0xFFF5F5F0),
      topBarBorder: Color(0xFF8E9379),
      topBarText: Color(0xFF111508),
      backButtonColor: Color(0xFFF5F5F0),
      avatarColor: Color(0xFF111508),
      bottomBarBackground: Color.fromARGB(255, 152, 198, 245),
      bottomBarIconColors: Color(0xFF0F172A),
      bottomBarIndicatorColor: Color(0xFF0F172A),
      bottomBarBorderColor: Color(0xFF0F172A),
    ),
    status: StatusColors(
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFF93000a),
      warning: Color(0xFFF59E0B),
      success: Color(0xFF10B981),
    ),
    shimmer: ShimmerColors(baseColor: Color(0xFFE2E8F0), highlightColor: Color(0xFFF1F5F9)),
  );

  /// Deep Emerald dark palette from `mockups/my_lists_dashboard/DESIGN.md`.
  static AppColors _getDarkColors() => const AppColors(
    accent: AccentColors(
      primaryFixed: Color(0xFF4EDEA3),
      onPrimaryFixed: Color(0xFF003824),
      primaryDisabled: Color(0xFF005236),
      onPrimaryDisabled: Color(0xFF6FFBBE),
      primaryContainer: Color(0xFF10B981),
      onPrimaryContainer: Color(0xFF00422B),
      headline: Color(0xFFD0E8DF),
      inversePrimary: Color(0xFF006C49),
    ),
    surface: SurfaceColors(
      scaffoldBackground: Color(0xFF031712),
      lowContrastBackground: Color(0xFF031712),
      primaryText: Color(0xFFD0E8DF),
      secondaryText: Color(0xFFBBCABF),
      cardBackground: Color(0xFF0F231E),
      cardBorder: Color(0xFF3C4A42),
      containerHigh: Color(0xFF192E28),
      containerLow: Color(0xFF0A1F1A),
      containerHighest: Color(0xFF243933),
      containerLowest: Color(0xFF00110D),
      outline: Color(0xFF86948A),
      secondaryContainer: Color(0xFF294E3F),
      onSecondaryContainer: Color(0xFF96BEAB),
      inverseSurface: Color(0xFFD0E8DF),
      inverseOnSurface: Color(0xFF20342F),
    ),
    appBar: AppBarColors(
      topBarBackground: Color(0xFF031712),
      topBarBorder: Color(0xFF3C4A42),
      topBarText: Color(0xFFD0E8DF),
      backButtonColor: Color(0xFFD0E8DF),
      avatarColor: Color(0xFF4EDEA3),
      bottomBarBackground: Color(0xFF031712),
      bottomBarIconColors: Color(0xFFD0E8DF),
      bottomBarIndicatorColor: Color(0xFF4EDEA3),
      bottomBarBorderColor: Color(0xFF4EDEA3),
    ),
    status: StatusColors(
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      warning: Color(0xFFF59E0B),
      success: Color(0xFF10B981),
    ),
    shimmer: ShimmerColors(
      baseColor: Color(0xFF0F231E),
      highlightColor: Color(0xFF192E28),
    ),
  );
}
