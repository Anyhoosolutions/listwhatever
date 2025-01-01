import 'package:listwhatever/pages/list/models/list_item.dart';

abstract class ListItemState {
  const ListItemState();
}

class ListItemInitial extends ListItemState {}

class ListItemLoading extends ListItemState {}

class ListItemLoaded extends ListItemState {
  const ListItemLoaded(this.listItem);
  final ListItem? listItem;
}
