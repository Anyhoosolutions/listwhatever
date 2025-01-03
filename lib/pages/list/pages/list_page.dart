import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:listwhatever/helpers/current_location_cubit.dart';
import 'package:listwhatever/pages/filter/bloc/filters_bloc.dart';
import 'package:listwhatever/pages/filter/bloc/filters_state.dart';
import 'package:listwhatever/pages/filter/routes/filter_page_route.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_items_sort_order_cubit.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/components/map_view.dart';
import 'package:listwhatever/pages/list/helpers/filters_helper.dart';
import 'package:listwhatever/pages/list/models/filters.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list/models/list_item_tile.dart';
import 'package:listwhatever/pages/list/routes/add_list_item_page_route.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';
import 'package:listwhatever/pages/lists/routes/edit_list_page_route.dart';
import 'package:listwhatever/routing/routes.dart';

const addListButtonKey = Key('AddListButtonKey');
const appBarExpandedHeight = 150.0;

class ListPage extends HookWidget {
  const ListPage({required this.listId, super.key});
  final String listId;

  @override
  Widget build(BuildContext context) {
    print('ListPage building');
    useEffect(
      () {
        print('ListPage getting list for listId: $listId');
        BlocProvider.of<ListBloc>(context).add(GetList(listId));
        return null;
      },
      [],
    );
    final showMap = useState(true);

    final listState = context.watch<ListBloc>().state;
    final filtersState = context.watch<FiltersBloc>().state;
    final filters = getFilters(filtersState);

    final isLoading = getLoading(listState, filtersState);
    final list = getList(listState);
    final items = getItems(listState);

    final currentLocation = context.watch<CurrentLocationCubit>().state;

    print('filters: $filters');
    final filteredItems = isLoading
        ? items
        : FiltersHelper.sortAndFilterItems(
            list!,
            items,
            filters!,
            (ListItemsSortOrder.name, SortOrder.ascending),
            currentLocation,
          );
    print('filteredItems: $filteredItems');
    final mapHeight = MediaQuery.of(context).size.height - appBarExpandedHeight;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: addListButtonKey,
        onPressed: () {
          AddListItemPageRoute(actualListId: list!.id!).push<void>(context);
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              if (showMap.value)
                IconButton(
                  onPressed: () {
                    showMap.value = false;
                  },
                  icon: const Icon(Icons.list),
                ),
              if (!showMap.value)
                IconButton(
                  onPressed: () {
                    showMap.value = true;
                  },
                  icon: const Icon(Icons.map),
                ),
              IconButton(
                onPressed: () {
                  FilterPageRoute(listId: list!.id!).push<void>(context);
                },
                icon: const Icon(Icons.filter_alt_outlined),
              ),
              PopupMenuButton<int>(
                onSelected: (item) => {
                  if (item == 0)
                    {
                      EditListPageRoute(id: list!.id!).push<void>(context),
                    },
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            pinned: true,
            expandedHeight: appBarExpandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/restaurants.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              list?.name ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          if (showMap.value)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Container(
                  height: mapHeight,
                  alignment: Alignment.centerLeft,
                  child: MapView(items: filteredItems),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListItemTile(
                      list: list,
                      item: filteredItems[index],
                      isLoading: isLoading,
                    ),
                  );
                },
                childCount: filteredItems.length,
              ),
            ),
        ],
      ),
    );
  }

  bool getLoading(ListState listState, FiltersState filtersState) {
    if (filtersState is! FiltersLoaded) {
      return true;
    }
    return switch (listState) {
      ListInitial() => true,
      ListLoading() => true,
      ListLoaded() => false,
    };
  }

  ListOfThings? getList(ListState listState) {
    if (listState is ListInitial) {
      return null;
    }
    if (listState is ListLoading) {
      return null;
    }
    if (listState is ListLoaded) {
      return listState.list;
    }
    return null;
  }

  List<ListItem> getItems(ListState listState) {
    if (listState is ListInitial) {
      return [];
    }
    if (listState is ListLoading) {
      return [];
    }
    if (listState is ListLoaded) {
      return listState.listItems;
    }
    return [];
  }

  Filters? getFilters(FiltersState filtersState) {
    if (filtersState is FiltersLoaded) {
      return filtersState.filters;
    }
    return null;
  }
}
