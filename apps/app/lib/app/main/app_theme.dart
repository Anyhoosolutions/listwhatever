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

  /// Mint surfaces with emerald accent (light counterpart to Deep Emerald).
  static AppColors _getLightColors() => const AppColors(
    accent: AccentColors(
      primaryFixed: Color(0xFF4EDEA3),
      onPrimaryFixed: Color(0xFF003824),
      primaryDisabled: Color(0xFFBAE6D4),
      onPrimaryDisabled: Color(0xFF006C49),
      primaryContainer: Color(0xFF10B981),
      onPrimaryContainer: Color(0xFF00422B),
      headline: Color(0xFF0A1F1A),
      inversePrimary: Color(0xFF006C49),
    ),
    surface: SurfaceColors(
      scaffoldBackground: Color(0xFFF2F8F4),
      lowContrastBackground: Color(0xFFE8F4ED),
      primaryText: Color(0xFF0A1F1A),
      secondaryText: Color(0xFF3C4A42),
      cardBackground: Color(0xFFFFFFFF),
      cardBorder: Color(0xFFA8CFBC),
      containerHigh: Color(0xFFD4EBE0),
      containerLow: Color(0xFFE8F4ED),
      containerHighest: Color(0xFFC3ECD7),
      containerLowest: Color(0xFFFFFFFF),
      outline: Color(0xFF6B8F7E),
      secondaryContainer: Color(0xFFD1FAE5),
      onSecondaryContainer: Color(0xFF006C49),
      inverseSurface: Color(0xFF20342F),
      inverseOnSurface: Color(0xFFD0E8DF),
    ),
    appBar: AppBarColors(
      topBarBackground: Color(0xFFF2F8F4),
      topBarBorder: Color(0xFFA8CFBC),
      topBarText: Color(0xFF0A1F1A),
      backButtonColor: Color(0xFF0A1F1A),
      avatarColor: Color(0xFF10B981),
      bottomBarBackground: Color(0xFFF2F8F4),
      bottomBarIconColors: Color(0xFF3C4A42),
      bottomBarIndicatorColor: Color(0xFF10B981),
      bottomBarBorderColor: Color(0xFFA8CFBC),
    ),
    status: StatusColors(
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      warning: Color(0xFFF59E0B),
      success: Color(0xFF10B981),
    ),
    shimmer: ShimmerColors(baseColor: Color(0xFFD4EBE0), highlightColor: Color(0xFFE8F4ED)),
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
