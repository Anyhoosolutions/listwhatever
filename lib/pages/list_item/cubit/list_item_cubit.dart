import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list/repository/list_item_repository.dart';

class ListItemCubit extends Cubit<ListItem?> {
  ListItemCubit({required this.listItemRepository}) : super(null);
  final ListItemRepository listItemRepository;

  void getListItem(String listId, String itemId) {
    listItemRepository.loadListItem(listId, itemId).then(emit);
    emit(null);
  }
}
