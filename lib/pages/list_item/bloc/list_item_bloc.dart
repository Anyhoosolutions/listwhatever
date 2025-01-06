import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listwhatever/pages/list/repository/list_item_repository.dart';
import 'list_item_event.dart';
import 'list_item_state.dart';

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  ListItemBloc({required this.listItemRepository}) : super(ListItemInitial()) {
    on<LoadListItem>(_onLoadListItem);
    on<WatchListItem>(_onWatchListItem);
    on<DeleteListItem>(_onDeleteListItem);
  }
  final ListItemRepository listItemRepository;

  Future<void> _onLoadListItem(LoadListItem event, Emitter<ListItemState> emit) async {
    emit(ListItemLoading());
    final listItem = await listItemRepository.loadListItem(event.listId, event.itemId);
    emit(ListItemLoaded(listItem));
  }

  Future<void> _onWatchListItem(WatchListItem event, Emitter<ListItemState> emit) async {
    emit(ListItemLoading());
    final listItem = listItemRepository.watchListItem(event.listId, event.itemId);
    await emit.forEach(listItem, onData: ListItemLoaded.new);
  }

  Future<void> _onDeleteListItem(DeleteListItem event, Emitter<ListItemState> emit) async {
    emit(ListItemLoading());
    await listItemRepository.deleteListItem(event.listId, event.itemId);
  }
}
