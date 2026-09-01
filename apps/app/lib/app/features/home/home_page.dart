import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/home_view.dart';
import 'package:listwhatever/app/features/home/list_preview.dart';
import 'package:listwhatever/app/routing/routes.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _allCategory = 'All';

  static const _lists = [
    ListPreview(
      id: 'movies',
      title: 'Movies to Watch',
      itemCount: 12,
      updatedLabel: 'Updated 2h ago',
      icon: Icons.movie_outlined,
      iconBackground: Color(0xFFEF4444),
      category: 'Personal',
    ),
    ListPreview(
      id: 'golf',
      title: 'Golf Courses',
      itemCount: 8,
      updatedLabel: 'Updated yesterday',
      icon: Icons.flag_outlined,
      iconBackground: Color(0xFF166534),
      category: 'Travel',
      hasLocations: true,
    ),
    ListPreview(
      id: 'groceries',
      title: 'Groceries',
      itemCount: 24,
      updatedLabel: 'Updated 4h ago',
      icon: Icons.shopping_cart_outlined,
      iconBackground: Color(0xFFF59E0B),
      category: 'Personal',
    ),
    ListPreview(
      id: 'trips',
      title: 'Dream Trips',
      itemCount: 5,
      updatedLabel: 'Updated last week',
      icon: Icons.flight_outlined,
      iconBackground: Color(0xFF3B82F6),
      category: 'Travel',
      hasLocations: true,
    ),
  ];

  static const _featured = FeaturedListPreview(
    id: 'cafes',
    title: 'Favorite Cafes',
    subtitle: '7 locations tagged.',
    badgeLabel: 'Map view enabled.',
  );

  static const _categories = ['All', 'Personal', 'Work', 'Travel', 'Shared'];

  String _selectedCategory = _allCategory;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final filtered = _lists.where((list) {
      final matchesCategory = _selectedCategory == _allCategory || list.category == _selectedCategory;
      final matchesQuery = _query.isEmpty || list.title.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return HomeView(
      lists: filtered,
      featured: FeaturedListPreview(
        id: _featured.id,
        title: t.homePage.featuredTitle,
        subtitle: t.homePage.featuredSubtitle,
        badgeLabel: t.homePage.featuredBadge,
      ),
      categories: _categories,
      selectedCategory: _selectedCategory,
      onCategorySelected: (category) {
        setState(() => _selectedCategory = category);
      },
      onSearchChanged: (value) {
        setState(() => _query = value);
      },
      onListTap: (list) => ListItemsRoute(listId: list.id).push(context),
    );
  }
}
