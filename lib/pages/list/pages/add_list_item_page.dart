import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/components/add_list_item_form.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

const String className = 'AddListItemPage';

class AddListItemPage extends HookWidget {
  const AddListItemPage({required this.listId, super.key});
  final String listId;

  @override
  Widget build(BuildContext context) {
    useEffect(
      // ignore: body_might_complete_normally_nullable
      () {
        print('AddListItemPage: Calling bloc');
        BlocProvider.of<ListBloc>(context).add(GetList(listId));
      },
      const [],
    );

    final listState = context.watch<ListBloc>().state;
    final isLoading = getLoading(listState);
    final list = getList(listState);

    print('AddListItemPage: listState: $listState');

    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AddListItemForm(
            list: list,
            isLoading: isLoading,
            save: save,
          ),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: const Text(/*listItem == null ?*/ 'Add item' /* : 'Edit item'*/),
      actions: const [
        // if (listItem != null)
        //   AppBarAction(
        //     type: AppBarActionType.icon,
        //     iconAction: AppBarActionIcon(
        //       title: AppLocalizations.of(context).deleteListItem,
        //       icon: Icons.delete,
        //       key: const Key('deleteListItemAction'),
        //       callback: () async {
        //         context
        //             .read<ListItemCrudBloc>()
        //             .add(DeleteListItem(widget.actualListId, listItem!.id!));
        //         context.read<RedirectCubit>().setRedirect(
        //               ListItemsPageRoute(actualListId: widget.actualListId)
        //                   .location,
        //             );
        //       },
        //     ),
        //   ),
      ],
    );
  }

  Future<void> save(
    BuildContext context,
    ListOfThings? list,
    Map<String, dynamic> values,
  ) async {
    final listBloc = BlocProvider.of<ListBloc>(context);
    final goRouter = GoRouter.of(context);

    var newItem = ListItem(
      id: null,
      name: values['name'] as String,
      info: values['info'] as String,
    );
    if (list?.withDates ?? false) {
      newItem = newItem.copyWith(
        datetime: values['date'] as DateTime,
      );
    }
    print('list: $list');
    print('newItem: $newItem');
    listBloc.add(AddListItem(list!.id!, newItem));
    goRouter.pop();
  }

  bool getLoading(ListState listState) {
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
}
