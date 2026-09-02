import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/pages/home_view.dart';
import 'package:listwhatever/app/features/lists/repositories/fake_dynamic_lists_repository.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

@widgetbook.UseCase(name: 'My Lists', type: HomeView, path: 'features/home')
Widget myListsDashboardUseCase(BuildContext context) {
  return starterViewHost(
    const _MyListsPreview(),
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
  @override
  Widget build(BuildContext context) {
    return HomeView(
      lists: FakeDynamicListsRepository.defaultLists,
      categories: ['All'],
      selectedCategory: '',
      onCategorySelected: (category) {},
      onSearchChanged: (value) {},
    );
  }
}
