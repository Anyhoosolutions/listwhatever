import 'package:flutter/material.dart';

class ListPreview {
  const ListPreview({
    required this.id,
    required this.title,
    required this.itemCount,
    required this.updatedLabel,
    required this.icon,
    required this.iconBackground,
    required this.category,
    this.hasLocations = false,
  });

  final String id;
  final String title;
  final int itemCount;
  final String updatedLabel;
  final IconData icon;
  final Color iconBackground;
  final String category;
  final bool hasLocations;
}

class FeaturedListPreview {
  const FeaturedListPreview({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.badgeLabel,
  });

  final String id;
  final String title;
  final String subtitle;
  final String badgeLabel;
}
