import 'package:flutter/material.dart';
import 'package:listwhatever/custom/pages/listItems/list_items_load_bloc/list_items_load_state.dart';

import '/custom/pages/lists/list_events/list_state.dart';
import '/custom/pages/lists/lists_events/lists_state.dart';
import '/custom/pages/shareList/bloc/shared_list_state.dart';
import '/standard/constants.dart';
import 'list_item_load_bloc/list_item_load_state.dart';

class ListOrListItemNotLoadedHandler {
  static Widget? handleListAndListItemsState(ListState listState, ListItemsLoadState listItemsState) {
    final listView = handleListState(listState);
    if (listView != null) {
      return listView;
    }
    final listItemsView = handleListItemsState(listItemsState);
    if (listItemsView != null) {
      return listItemsView;
    }
    return null;
  }

  static Widget? handleListAndListItemState(ListState listState, ListItemState listItemState) {
    final listView = handleListState(listState);
    if (listView != null) {
      return listView;
    }
    final listItemView = handleListItemState(listItemState);
    if (listItemView != null) {
      return listItemView;
    }
    return null;
  }

  static Widget? handleUserListsState(ListsState listsState) {
    return switch (listsState) {
      ListsError() => getErrorWidget(listsState.errorMessage),
      ListsInitial() => initialListsView(),
      ListsLoading() => loadingListsView(),
      ListsOperationSuccess() => const Center(child: CircularProgressIndicator()),
      ListsLoaded() => null,
    };
  }

  static Widget? handleListState(ListState listState) {
    return switch (listState) {
      ListError() => getErrorWidget(listState.errorMessage),
      ListInitial() => initialListView(),
      ListLoading() => loadingListView(),
      ListOperationSuccess() => const Center(child: CircularProgressIndicator()),
      ListLoaded() => null,
      ListDeleted() => Container(),
    };
  }

  static Widget? handleListItemsState(ListItemsLoadState listItemsState) {
    return switch (listItemsState) {
      ListItemsLoadError() => getErrorWidget(listItemsState.errorMessage),
      ListItemsLoadInitial() => const Center(child: CircularProgressIndicator()),
      ListItemsLoadLoading() => const Center(child: CircularProgressIndicator()),
      ListItemsLoadLoaded() => null,
    };
  }

  static Widget? handleListItemState(ListItemState listItemState) {
    return switch (listItemState) {
      ListItemError() => getErrorWidget(listItemState.errorMessage),
      ListItemInitial() => const Center(child: CircularProgressIndicator()),
      ListItemLoading() => const Center(child: CircularProgressIndicator()),
      ListItemLoaded() => null,
    };
  }

  static Widget? handleSharedListState(SharedListState listState) {
    return switch (listState) {
      SharedListError() => getErrorWidget(listState.errorMessage),
      SharedListInitial() => initialListView(),
      SharedListLoading() => loadingListView(),
      SharedListOperationSuccess() => const Center(child: CircularProgressIndicator()),
      SharedListLoaded() => null,
    };
  }

  static Widget getErrorWidget(String errorMessage) {
    return Center(child: Text(errorMessage));
  }

  static Widget initialListView() {
    logger.i('initialListView');
    return const Center(child: CircularProgressIndicator());
  }

  static Widget loadingListView() {
    logger.i('loadingListView');
    return const Center(child: CircularProgressIndicator());
  }

  static Widget initialListsView() {
    logger.i('initialListsView');
    return const Center(child: CircularProgressIndicator());
  }

  static Widget loadingListsView() {
    logger.i('loadingListsView');
    return const Center(child: CircularProgressIndicator());
  }
}
