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
