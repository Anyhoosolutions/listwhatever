import 'package:bloc/bloc.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_state.dart';
import 'package:listwhatever/app/features/lists/dynamic_lists_repository.dart';

class DynamicListsCubit extends Cubit<DynamicListsState> {
  DynamicListsCubit({required this._repository}) : super(const DynamicListsState());

  final DynamicListsRepository _repository;

  Future<void> load() async {
    emit(const DynamicListsState(isLoading: true));
    try {
      final lists = await _repository.listAll();
      emit(DynamicListsState(data: lists));
    } catch (error) {
      emit(DynamicListsState(errorMessage: error.toString()));
    }
  }
}
