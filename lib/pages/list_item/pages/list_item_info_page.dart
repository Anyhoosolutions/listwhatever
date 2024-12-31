import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list_item/cubit/list_item_cubit.dart';

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
        context.read<ListItemCubit>().getListItem(listId, itemId);
      },
      const [],
    );

    final listItem = context.watch<ListItemCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: (listItem == null) ? const Text('Item') : Text(listItem.name),
      ),
      body: (listItem == null) ? loadingView() : infoView(listItem),
    );
  }

  Widget loadingView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
    );
  }

  Widget infoView(ListItem listItem) {
    return Column(
      children: [
        const Text('Name:'),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(listItem.name),
        ),
        const Text('Date:'),
        Text(listItem.datetime.toString()),
      ],
    );
  }
}
