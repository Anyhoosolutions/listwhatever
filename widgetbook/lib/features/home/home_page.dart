import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/home_view.dart';
import 'package:listwhatever/app/features/home/list_preview.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

@widgetbook.UseCase(name: 'My Lists', type: HomeView, path: 'features/home')
Widget myListsDashboardUseCase(BuildContext context) {
  return starterViewHost(
    const _MyListsPreview(),
    themeMode: ThemeMode.dark,
    appBar: const AnyhooTopBar(topBarTitle: 'My Lists'),
    floatingActionButton: Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {},
        backgroundColor: context.accent.primaryFixed,
        foregroundColor: context.accent.onPrimaryFixed,
        child: const Icon(Icons.add),
      ),
    ),
    bottomNavigationBar: AnyhooBottomBar(
      selectedIndex: 0,
      destinations: [
        AnyhooBottomBarButton(icon: Icons.grid_view_rounded, label: 'Dashboard', onTap: () {}),
        AnyhooBottomBarButton(icon: Icons.map_outlined, label: 'Map View', onTap: () {}),
        AnyhooBottomBarButton(icon: Icons.favorite_border, label: 'Favorites', onTap: () {}),
        AnyhooBottomBarButton(icon: Icons.person_outline, label: 'Profile', onTap: () {}),
      ],
    ),
  );
}

class _MyListsPreview extends StatefulWidget {
  const _MyListsPreview();

  @override
  State<_MyListsPreview> createState() => _MyListsPreviewState();
}

class _MyListsPreviewState extends State<_MyListsPreview> {
  static const _allCategory = 'All';
  static const _categories = ['All', 'Personal', 'Work', 'Travel', 'Shared'];

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

  String _selectedCategory = _allCategory;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _lists.where((list) {
      final matchesCategory = _selectedCategory == _allCategory || list.category == _selectedCategory;
      final matchesQuery = _query.isEmpty || list.title.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return HomeView(
      lists: filtered,
      featured: _featured,
      categories: _categories,
      selectedCategory: _selectedCategory,
      onCategorySelected: (category) => setState(() => _selectedCategory = category),
      onSearchChanged: (value) => setState(() => _query = value),
    );
  }
}
