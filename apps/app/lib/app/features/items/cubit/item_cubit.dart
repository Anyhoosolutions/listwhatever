import 'package:bloc/bloc.dart';
import 'package:listwhatever/app/features/items/cubit/item_state.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit({required this._repository}) : super(const ItemState());

  final ItemsRepository _repository;

  Future<void> load(String itemId) async {
    emit(const ItemState(isLoading: true));
    try {
      final item = await _repository.getById(itemId);
      if (item == null) {
        emit(const ItemState(errorMessage: 'Item not found'));
        return;
      }
      emit(ItemState(data: item));
    } catch (error) {
      emit(ItemState(errorMessage: error.toString()));
    }
  }
}
