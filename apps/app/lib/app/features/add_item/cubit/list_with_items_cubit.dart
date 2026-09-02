import 'package:bloc/bloc.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_state.dart';
import 'package:listwhatever/app/features/lists/repositories/dynamic_lists_repository.dart';
import 'package:listwhatever/app/features/list_items/repositories/list_items_repository.dart';

class ListWithItemsCubit extends Cubit<ListWithItemsState> {
  ListWithItemsCubit({
    required this._listRepository,
    required this._listItemsRepository,
  }) : super(const ListWithItemsState());

  final DynamicListsRepository _listRepository;
  final ListItemsRepository _listItemsRepository;

  Future<void> load(String listId) async {
    emit(const ListWithItemsState(isLoading: true));
    try {
      final list = await _listRepository.getById(listId);
      final items = await _listItemsRepository.listByListId(listId);

      if (list == null) {
        emit(ListWithItemsState(errorMessage: 'List or items not found'));
        return;
      }

      emit(
        ListWithItemsState(
          data: ListWithItems(
            id: list.id,
            ownerId: list.ownerId,
            title: list.title,
            description: list.description,
            visibility: list.visibility,
            collaboratorIds: list.collaboratorIds,
            items: items,
            hasLocations: list.hasLocations,
            createdAt: list.createdAt,
            updatedAt: list.updatedAt,
            icon: list.icon,
            iconBackground: list.iconBackground,
          ),
        ),
      );
    } catch (error) {
      emit(ListWithItemsState(errorMessage: error.toString()));
    }
  }
}
