import 'package:core_models/core_models.dart';

enum ListItemAccess { public, private }

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
      latlong: const LatLong(latitude: 36.88, longitude: -121.48),
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
      latlong: const LatLong(latitude: 37.02, longitude: -121.62),
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
      latlong: const LatLong(latitude: 36.72, longitude: -121.28),
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
      latlong: const LatLong(latitude: 37.08, longitude: -121.2),
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
      latlong: const LatLong(latitude: 36.8, longitude: -121.72),
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
