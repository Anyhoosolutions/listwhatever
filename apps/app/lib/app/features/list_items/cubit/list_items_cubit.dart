import 'package:bloc/bloc.dart';
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
}
