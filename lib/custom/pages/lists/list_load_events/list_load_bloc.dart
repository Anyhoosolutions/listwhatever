import 'package:bloc/bloc.dart';
import '/custom/pages/lists/lists_service.dart';
import '/custom/pages/lists/user_lists_service.dart';

import '/standard/constants.dart';
import 'list_load_event.dart';
import 'list_load_state.dart';

class ListLoadBloc extends Bloc<ListLoadEvent, ListLoadState> {
  ListLoadBloc(this._userListsService, this._listsService) : super(ListLoadInitial()) {
    on<ChangeUserForListLoad>(_onChangeUser);
    on<LoadList>(_onLoadList);
  }
  final UserListsService _userListsService;
  final ListsService _listsService;

  Future<void> _onChangeUser(ChangeUserForListLoad event, Emitter<ListLoadState> emit) async {
    try {
      emit(ListLoadLoading());
      _listsService.changeUser(event.userId);
      emit(ListLoadLoaded(null));
    } catch (e) {
      logger.e('Error: $e');
      emit(ListLoadError('Failed to change user.\n$e'));
    }
  }

  Future<void> _onLoadList(LoadList event, Emitter<ListLoadState> emit) async {
    logger.i('$this => getting list  ${event.listId}');
    try {
      emit(ListLoadLoading());
      final userList = await _userListsService.getList(event.listId);
      final list = await _listsService.getList(userList.listId);
      emit(ListLoadLoaded(list));
    } catch (e) {
      logger.e('Error: $e');
      emit(ListLoadError('Failed to load lists.\n$e'));
    }
  }
}