import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';

class ColorMapping {
  static Color colorFor(ListItemIconBackground? background) {
    return switch (background) {
      ListItemIconBackground.blue => const Color(0xFF3B82F6),
      ListItemIconBackground.red => const Color(0xFFEF4444),
      ListItemIconBackground.green => const Color(0xFF10B981),
      ListItemIconBackground.orange => const Color(0xFFEA580C),
      ListItemIconBackground.purple => const Color(0xFF8B5CF6),
      ListItemIconBackground.yellow => const Color(0xFFF59E0B),
      ListItemIconBackground.bronze => const Color(0xFFD946EF),
      ListItemIconBackground.lightblue => const Color(0xFF06B6D4),
      ListItemIconBackground.lightpurple => const Color(0xFFEC4899),
      ListItemIconBackground.lightgreen => const Color(0xFF84CC16),
      ListItemIconBackground.pink => const Color(0xFFD946EF),
      null => const Color(0xFF64748B),
    };
  }
}

class IconMapping {
  static IconData iconDataFor(ListItemIcon? icon) {
    return switch (icon) {
      ListItemIcon.movie => Icons.movie_outlined,
      ListItemIcon.restaurant => Icons.restaurant_outlined,
      ListItemIcon.hotel => Icons.hotel_outlined,
      ListItemIcon.flight => Icons.flight_outlined,
      ListItemIcon.car => Icons.directions_car_outlined,
      ListItemIcon.train => Icons.train_outlined,
      ListItemIcon.bus => Icons.directions_bus_outlined,
      ListItemIcon.flag => Icons.flag_outlined,
      ListItemIcon.park => Icons.park_outlined,
      ListItemIcon.golfCourse => Icons.golf_course_outlined,
      ListItemIcon.eco => Icons.eco_outlined,
      ListItemIcon.waves => Icons.waves_outlined,
      null => Icons.place_outlined,
    };
  }
}
