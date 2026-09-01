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

abstract final class ListItemsSampleData {
  static final _now = DateTime.utc(2026, 9, 1, 17);

  static final golfCourses = [
    ListItem(
      id: 'pebble',
      title: 'Pebble Beach Golf Links',
      notes: 'Iconic coastal destination featuring scenic golf courses, luxury resort...',
      address: 'California',
      categoryValues: {
        'access': ListItemAccess.public.name,
        'par': 72,
        'rating': 4.9,
        'distanceLabel': '5 miles away',
        'mapX': 0.42,
        'mapY': 0.38,
      },
      langlong: const LatLong(latitude: 36.88, longitude: -121.48),
      createdAt: _now,
      updatedAt: _now,
      icon: ListItemIcon.flag,
      iconBackground: ListItemIconBackground.green,
    ),
    ListItem(
      id: 'cypress',
      title: 'Cypress Point Club',
      notes: 'Exclusive clifftop layout known for its cypress trees and ocean holes.',
      address: 'California',
      categoryValues: {
        'access': ListItemAccess.private.name,
        'par': 72,
        'rating': 5.0,
        'distanceLabel': '8 miles away',
        'mapX': 0.28,
        'mapY': 0.52,
      },
      langlong: const LatLong(latitude: 37.02, longitude: -121.62),
      createdAt: _now,
      updatedAt: _now,
      icon: ListItemIcon.park,
      iconBackground: ListItemIconBackground.green,
    ),
    ListItem(
      id: 'st-andrews',
      title: 'St Andrews (Old Course)',
      notes: 'The home of golf, with historic fairways and a town-center finish.',
      address: 'Scotland',
      categoryValues: {
        'access': ListItemAccess.public.name,
        'par': 72,
        'rating': 4.8,
        'distanceLabel': '5,200 miles away',
        'mapX': 0.62,
        'mapY': 0.22,
      },
      langlong: const LatLong(latitude: 36.72, longitude: -121.28),
      createdAt: _now,
      updatedAt: _now,
      icon: ListItemIcon.golfCourse,
      iconBackground: ListItemIconBackground.blue,
    ),
    ListItem(
      id: 'augusta',
      title: 'Augusta National',
      notes: 'Home of the Masters, famous for amen corner and azaleas.',
      address: 'Georgia',
      categoryValues: {
        'access': ListItemAccess.private.name,
        'par': 72,
        'rating': 5.0,
        'distanceLabel': '2,400 miles away',
        'mapX': 0.7,
        'mapY': 0.58,
      },
      langlong: const LatLong(latitude: 37.08, longitude: -121.2),
      createdAt: _now,
      updatedAt: _now,
      icon: ListItemIcon.eco,
      iconBackground: ListItemIconBackground.green,
    ),
    ListItem(
      id: 'county-down',
      title: 'Royal County Down',
      notes: 'Links golf beneath the Mountains of Mourne, with dunes and sea views.',
      address: 'Northern Ireland',
      categoryValues: {
        'access': ListItemAccess.private.name,
        'par': 71,
        'rating': 4.9,
        'distanceLabel': '5,100 miles away',
        'mapX': 0.18,
        'mapY': 0.3,
      },
      langlong: const LatLong(latitude: 36.8, longitude: -121.72),
      createdAt: _now,
      updatedAt: _now,
      icon: ListItemIcon.waves,
      iconBackground: ListItemIconBackground.purple,
    ),
  ];

  static List<ListItem> forListId(String listId) {
    return switch (listId) {
      'golf' => golfCourses,
      'trips' => golfCourses,
      _ => golfCourses,
    };
  }

  static bool hasLocations(String listId) => listId == 'golf' || listId == 'trips';
}
