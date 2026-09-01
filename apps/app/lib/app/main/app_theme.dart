import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => AnyhooTheme.light(colors: _getLightColors());
  static ThemeData get dark => AnyhooTheme.dark(colors: _getLightColors());

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
      topBarBackground: Color.fromARGB(255, 58, 132, 205),
      topBarText: Color(0xFF0F172A),
      bottomBarBackground: Color.fromARGB(255, 152, 198, 245),
      bottomBarIconColors: Color(0xFF0F172A),
    ),
    appBar: AppBarColors(
      topBarBackground: Color(0xFFF5F5F0),
      topBarBorder: Color(0xFF8E9379),
      topBarText: Color(0xFF111508),
      backButtonColor: Color(0xFFF5F5F0),
      iconColor: Color(0xFF111508),
      bottomBarBackground: Color(0xFFF5F5F0),
      bottomBarIconColors: Color(0xFF111508),
    ),
    status: StatusColors(
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFF93000a),
      warning: Color(0xFFF59E0B),
      success: Color(0xFF10B981),
    ),
    shimmer: ShimmerColors(baseColor: Color(0xFFE2E8F0), highlightColor: Color(0xFFF1F5F9)),
  );
}
