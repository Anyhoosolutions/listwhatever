import 'package:bloc/bloc.dart';
import '/custom/pages/shareList/shared_lists_service.dart';

import 'shared_list_event.dart';
import 'shared_list_state.dart';

class SharedListBloc extends Bloc<SharedListEvent, SharedListState> {
  SharedListBloc(this._sharedListsService) : super(SharedListInitial()) {
    on<LoadSharedList>(_onLoadSharedList);
  }

  final SharedListsService _sharedListsService;

  Future<void> _onLoadSharedList(
    LoadSharedList event,
    Emitter<SharedListState> emit,
  ) async {
    //
    try {
      emit(SharedListLoading());
      final sharedList =
          await _sharedListsService.getSharedList(event.shareCode);
      emit(SharedListLoaded(sharedList));
    } catch (e) {
      emit(SharedListError('Failed to load shared lists.\n$e'));
    }
  }
}
