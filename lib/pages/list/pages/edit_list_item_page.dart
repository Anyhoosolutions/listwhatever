import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/components/add_list_item_form.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list_item/bloc/list_item_bloc.dart';
import 'package:listwhatever/pages/list_item/bloc/list_item_event.dart';
import 'package:listwhatever/pages/list_item/bloc/list_item_state.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

const String className = 'EditListItemPage';

enum SectionName {
  mainInfo._('Main info'),
  categories._('Categories'),
  urls._('Urls'),
  date._('Date'),
  location._('Location'),
  submit._('Submit');

  const SectionName._(this.value);

  final String value;
}

enum FieldId {
  name._('name'),
  info._('info'),
  categories._('categories'),
  addCategory._('addCategory'),
  date._('date'),
  urls._('urls'),
  addUrl._('addUrl'),
  address._('address'),
  latlong._('latlong'),
  searchPhrase._('searchPhrase'),
  cancel._('cancel'),
  submit._('submit');

  const FieldId._(this.value);

  final String value;
}

final addListItemFormKey = GlobalKey<FormBuilderState>();

class EditListItemPage extends HookWidget {
  const EditListItemPage({required this.listId, required this.itemId, super.key});
  final String listId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    useEffect(
      // ignore: body_might_complete_normally_nullable
      () {
        print('EditListItemPage: Calling bloc');
        BlocProvider.of<ListBloc>(context).add(GetList(listId));
        BlocProvider.of<ListItemBloc>(context).add(WatchListItem(listId, itemId));
      },
      const [],
    );

    final listState = context.watch<ListBloc>().state;
    final listItemState = context.watch<ListItemBloc>().state;
    final listItem = getListItem(listItemState);
    final isLoading = getLoading(listState, listItem);
    final list = getList(listState);

    print('EditListItemPage: listState: $listState');

    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AddListItemForm(
            list: list,
            listItem: listItem,
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

  void save(
    BuildContext context,
    ListOfThings? list,
    ListItem listItem,
  ) {
    BlocProvider.of<ListBloc>(context).add(EditListItem(listId, listItem));
    GoRouter.of(context).pop();
  }

  bool getLoading(ListState listState, ListItem? listItem) {
    if (listItem == null) {
      return true;
    }
    return switch (listState) {
      ListInitial() => true,
      ListLoading() => true,
      ListLoaded() => false,
    };
  }

  ListOfThings? getList(ListState listState) {
    if (listState is ListLoaded) {
      return listState.list;
    }
    return null;
  }

  ListItem? getListItem(ListItemState listItemState) {
    if (listItemState is ListItemLoaded) {
      return listItemState.listItem;
    }
    return null;
  }
}
