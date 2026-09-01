import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/home_view.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_cubit.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_state.dart';
import 'package:listwhatever/app/routing/routes.dart';
// import 'package:listwhatever/i18n/strings.g.dart';
import 'package:listwhatever/shared/cubit_helpers/state_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _allCategory = 'All';

  static const _categories = ['All', 'Personal', 'Work', 'Travel', 'Shared'];

  String _selectedCategory = _allCategory;
  // String _query = '';

  @override
  Widget build(BuildContext context) {
    // final t = Translations.of(context);
    // final filtered = _lists.where((list) {
    //   final matchesCategory = _selectedCategory == _allCategory || list.category == _selectedCategory;
    //   final matchesQuery = _query.isEmpty || list.title.toLowerCase().contains(_query.toLowerCase());
    //   return matchesCategory && matchesQuery;
    // }).toList();

    final body = StateSwitcher<DynamicListsCubit, DynamicListsState, List<DynamicList>>(
      skeleton: const Text('Loading...'),
      emptyBuilder: (context, cubit) => const Text('No data'),
      successBuilder: (context, data, cubit) => HomeView(
        lists: data,
        categories: _categories,
        selectedCategory: _selectedCategory,
        onCategorySelected: (category) {
          setState(() => _selectedCategory = category);
        },
        onSearchChanged: (value) {
          // setState(() => _query = value);
        },
        onListTap: (list) => ListItemsRoute(listId: list.id).push(context),
      ),
    );

    return body;
  }
}
