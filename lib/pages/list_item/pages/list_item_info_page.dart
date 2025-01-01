import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:listwhatever/helpers/date_format_helper.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list/routes/edit_list_item_page_route.dart';
import 'package:listwhatever/pages/list_item/cubit/list_item_cubit.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';
import 'package:listwhatever/routing/routes.dart';

class ListItemInfoPage extends HookWidget {
  const ListItemInfoPage({
    required this.listId,
    required this.itemId,
    super.key,
  });
  final String listId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    useEffect(
      // ignore: body_might_complete_normally_nullable
      () {
        print('ListItemInfoPage: Calling bloc');
        context.read<ListBloc>().add(GetList(listId));
        context.read<ListItemCubit>().getListItem(listId, itemId);
      },
      const [],
    );

    final listState = context.watch<ListBloc>().state;
    final list = getList(listState);
    final listItem = context.watch<ListItemCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: (listItem == null) ? const Text('Item') : Text(listItem.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              EditListItemPageRoute(listId: listId, itemId: itemId).push<void>(context);
            },
          ),
        ],
      ),
      body: (listItem == null || list == null) ? _loadingView() : _infoView(list, listItem),
    );
  }

  Widget _loadingView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
    );
  }

  Widget _infoView(ListOfThings list, ListItem listItem) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildTile('Name', listItem.name),
          if (list.withDates)
            _buildTile(
              'Date',
              listItem.datetime != null
                  ? DateFormatHelper.formatReadableDate(listItem.datetime!, DateFormatType.iso8601andTime)
                  : 'No date',
            ),
          _buildTile('Info', listItem.info != null && listItem.info!.isNotEmpty ? listItem.info! : ''),
          _buildTileMultipleValues('Urls', listItem.urls),
          _buildTileMultipleValues(
            'Categories',
            listItem.categories.entries.map((e) => '${e.key}: ${e.value.join(', ')}').toList(),
          ),
          if (list.withMap) _buildTile('Address', listItem.address ?? 'No address'),
        ],
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.yellow)),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildTileMultipleValues(String title, List<String> values) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.yellow)),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                values.map((v) => Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))).toList(),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  ListOfThings? getList(ListState listState) {
    if (listState is ListLoaded) {
      return listState.list;
    }
    return null;
  }
}
