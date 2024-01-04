import 'package:bloc/bloc.dart';
import '/custom/firestore/lists/lists.dart';
import '/custom/firestore/sharedList/shared_lists_service.dart';
import '/standard/constants.dart';

import 'subscribe_list_event.dart';
import 'subscribe_list_state.dart';

class SubscribeListBloc extends Bloc<SubscribeListEvent, SubscribeListState> {
  SubscribeListBloc(
    this._sharedListsService,
    this._listService,
  ) : super(SubscribeListInitial()) {
    on<SubscribeListForUser>(_onSubscribeListForUser);
  }

  final SharedListsService _sharedListsService;
  final ListsService _listService;

  Future<void> _onSubscribeListForUser(SubscribeListForUser event, Emitter<SubscribeListState> emit) async {
    // logger.i('_onLoadSharedList');
    try {
      emit(SubscribeListLoading());
      final userId = _listService.userId!;

      final sharedList = await _sharedListsService.getSharedList(event.shareCode);

      await _sharedListsService.addUser(event.shareCode, userId);

      emit(SubscribeListLoaded(sharedList));
    } catch (e) {
      logger.e('Error: $e');
      emit(SubscribeListError('Failed to load shared lists.\n$e'));
    }
  }
}