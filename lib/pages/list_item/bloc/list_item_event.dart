sealed class ListItemEvent {
  const ListItemEvent();
}

class LoadListItem extends ListItemEvent {
  const LoadListItem(this.listId, this.itemId);
  final String listId;
  final String itemId;
}

class WatchListItem extends ListItemEvent {
  const WatchListItem(this.listId, this.itemId);
  final String listId;
  final String itemId;
}

class DeleteListItem extends ListItemEvent {
  const DeleteListItem(this.listId, this.itemId);
  final String listId;
  final String itemId;
}
