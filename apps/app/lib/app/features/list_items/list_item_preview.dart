import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';

enum ListItemAccess { public, private }

class ListItemPreview {
  const ListItemPreview({
    required this.id,
    required this.title,
    required this.access,
    required this.par,
    required this.rating,
    required this.location,
    required this.description,
    required this.distanceLabel,
    required this.icon,
    required this.iconBackground,
    required this.mapX,
    required this.mapY,
  });

  final String id;
  final String title;
  final ListItemAccess access;
  final int par;
  final double rating;
  final String location;
  final String description;
  final String distanceLabel;
  final IconData icon;
  final Color iconBackground;

  /// Horizontal pin position on the placeholder map, 0–1.
  final double mapX;

  /// Vertical pin position on the placeholder map, 0–1.
  final double mapY;

  factory ListItemPreview.fromListItem(ListItem item) {
    final values = item.categoryValues;
    final accessName = values['access'] as String?;
    return ListItemPreview(
      id: item.id,
      title: item.title,
      access: accessName == ListItemAccess.private.name ? ListItemAccess.private : ListItemAccess.public,
      par: (values['par'] as num?)?.toInt() ?? 0,
      rating: (values['rating'] as num?)?.toDouble() ?? 0,
      location: item.address ?? '',
      description: item.notes,
      distanceLabel: values['distanceLabel'] as String? ?? '',
      icon: iconDataFor(item.icon),
      iconBackground: colorFor(item.iconBackground),
      mapX: (values['mapX'] as num?)?.toDouble() ?? 0.5,
      mapY: (values['mapY'] as num?)?.toDouble() ?? 0.5,
    );
  }
}

IconData iconDataFor(ListItemIcon? icon) {
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

Color colorFor(ListItemIconBackground? background) {
  return switch (background) {
    ListItemIconBackground.red => const Color(0xFFEF4444),
    ListItemIconBackground.green => const Color(0xFF166534),
    ListItemIconBackground.blue => const Color(0xFF1D4ED8),
    ListItemIconBackground.yellow => const Color(0xFFF59E0B),
    ListItemIconBackground.purple => const Color(0xFF4338CA),
    null => const Color(0xFF64748B),
  };
}

ListItemIcon iconFromPreview(ListItemPreview preview) {
  if (preview.icon == Icons.movie_outlined) return ListItemIcon.movie;
  if (preview.icon == Icons.restaurant_outlined) return ListItemIcon.restaurant;
  if (preview.icon == Icons.hotel_outlined) return ListItemIcon.hotel;
  if (preview.icon == Icons.flight_outlined) return ListItemIcon.flight;
  if (preview.icon == Icons.directions_car_outlined) return ListItemIcon.car;
  if (preview.icon == Icons.train_outlined) return ListItemIcon.train;
  if (preview.icon == Icons.directions_bus_outlined) return ListItemIcon.bus;
  if (preview.icon == Icons.flag_outlined) return ListItemIcon.flag;
  if (preview.icon == Icons.park_outlined) return ListItemIcon.park;
  if (preview.icon == Icons.golf_course_outlined) return ListItemIcon.golfCourse;
  if (preview.icon == Icons.eco_outlined) return ListItemIcon.eco;
  if (preview.icon == Icons.waves_outlined) return ListItemIcon.waves;
  return ListItemIcon.flag;
}

ListItemIconBackground backgroundFromPreview(ListItemPreview preview) {
  if (preview.iconBackground == const Color(0xFFEF4444)) return ListItemIconBackground.red;
  if (preview.iconBackground == const Color(0xFF1D4ED8) || preview.iconBackground == const Color(0xFF3B82F6)) {
    return ListItemIconBackground.blue;
  }
  if (preview.iconBackground == const Color(0xFFF59E0B)) return ListItemIconBackground.yellow;
  if (preview.iconBackground == const Color(0xFF4338CA)) return ListItemIconBackground.purple;
  return ListItemIconBackground.green;
}

abstract final class ListItemsSampleData {
  static const golfCourses = [
    ListItemPreview(
      id: 'pebble',
      title: 'Pebble Beach Golf Links',
      access: ListItemAccess.public,
      par: 72,
      rating: 4.9,
      location: 'California',
      description: 'Iconic coastal destination featuring scenic golf courses, luxury resort...',
      distanceLabel: '5 miles away',
      icon: Icons.flag_outlined,
      iconBackground: Color(0xFF166534),
      mapX: 0.42,
      mapY: 0.38,
    ),
    ListItemPreview(
      id: 'cypress',
      title: 'Cypress Point Club',
      access: ListItemAccess.private,
      par: 72,
      rating: 5.0,
      location: 'California',
      description: 'Exclusive clifftop layout known for its cypress trees and ocean holes.',
      distanceLabel: '8 miles away',
      icon: Icons.park_outlined,
      iconBackground: Color(0xFF0F766E),
      mapX: 0.28,
      mapY: 0.52,
    ),
    ListItemPreview(
      id: 'st-andrews',
      title: 'St Andrews (Old Course)',
      access: ListItemAccess.public,
      par: 72,
      rating: 4.8,
      location: 'Scotland',
      description: 'The home of golf, with historic fairways and a town-center finish.',
      distanceLabel: '5,200 miles away',
      icon: Icons.golf_course_outlined,
      iconBackground: Color(0xFF1D4ED8),
      mapX: 0.62,
      mapY: 0.22,
    ),
    ListItemPreview(
      id: 'augusta',
      title: 'Augusta National',
      access: ListItemAccess.private,
      par: 72,
      rating: 5.0,
      location: 'Georgia',
      description: 'Home of the Masters, famous for amen corner and azaleas.',
      distanceLabel: '2,400 miles away',
      icon: Icons.eco_outlined,
      iconBackground: Color(0xFF15803D),
      mapX: 0.7,
      mapY: 0.58,
    ),
    ListItemPreview(
      id: 'county-down',
      title: 'Royal County Down',
      access: ListItemAccess.private,
      par: 71,
      rating: 4.9,
      location: 'Northern Ireland',
      description: 'Links golf beneath the Mountains of Mourne, with dunes and sea views.',
      distanceLabel: '5,100 miles away',
      icon: Icons.waves_outlined,
      iconBackground: Color(0xFF4338CA),
      mapX: 0.18,
      mapY: 0.3,
    ),
  ];

  static List<ListItemPreview> forListId(String listId) {
    return switch (listId) {
      'golf' => golfCourses,
      'trips' => golfCourses,
      _ => golfCourses,
    };
  }

  static bool hasLocations(String listId) => listId == 'golf' || listId == 'trips';
}
