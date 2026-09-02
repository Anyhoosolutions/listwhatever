import 'package:bloc/bloc.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_state.dart';
import 'package:listwhatever/app/features/list_items/list_items_repository.dart';

class ListItemsCubit extends Cubit<ListItemsState> {
  ListItemsCubit({required this._repository}) : super(const ListItemsState());

  final ListItemsRepository _repository;

  Future<void> load(String listId) async {
    emit(const ListItemsState(isLoading: true));
    try {
      final items = await _repository.listByListId(listId);
      emit(ListItemsState(data: items));
    } catch (error) {
      emit(ListItemsState(errorMessage: error.toString()));
    }
  }

  Future<void> create(String listId, ListItem item) async {
    emit(ListItemsState(data: state.data, isLoading: true));
    try {
      print('create: $item');
      await _repository.create(listId: listId, item: item);
      final items = await _repository.listByListId(listId);
      print('create items: $items');
      print('create items: ${items.length}');
      emit(ListItemsState(data: items));
    } catch (error) {
      print('create error: $error');
      emit(ListItemsState(data: state.data, errorMessage: error.toString()));
    }
  }

  Future<void> update(String listId, ListItem item) async {
    emit(ListItemsState(data: state.data, isLoading: true));
    try {
      await _repository.update(listId: listId, item: item);
      final items = await _repository.listByListId(listId);
      emit(ListItemsState(data: items));
    } catch (error) {
      emit(ListItemsState(data: state.data, errorMessage: error.toString()));
    }
  }

  Future<void> delete(String listId, String itemId) async {
    emit(ListItemsState(data: state.data, isLoading: true));
    try {
      await _repository.delete(listId: listId, itemId: itemId);
      final items = await _repository.listByListId(listId);
      emit(ListItemsState(data: items));
    } catch (error) {
      emit(ListItemsState(data: state.data, errorMessage: error.toString()));
    }
  }
}
