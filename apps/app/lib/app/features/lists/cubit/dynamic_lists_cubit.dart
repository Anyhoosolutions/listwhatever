import 'package:bloc/bloc.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_state.dart';
import 'package:listwhatever/app/features/lists/repositories/dynamic_lists_repository.dart';

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

  Future<void> create(DynamicList list) async {
    emit(DynamicListsState(data: state.data, isLoading: true));
    try {
      await _repository.create(list);
      final lists = await _repository.listAll();
      emit(DynamicListsState(data: lists));
    } catch (error) {
      emit(DynamicListsState(data: state.data, errorMessage: error.toString()));
    }
  }

  Future<void> update(DynamicList list) async {
    emit(DynamicListsState(data: state.data, isLoading: true));
    try {
      await _repository.update(list);
      final lists = await _repository.listAll();
      emit(DynamicListsState(data: lists));
    } catch (error) {
      emit(DynamicListsState(data: state.data, errorMessage: error.toString()));
    }
  }

  Future<void> delete(String id) async {
    emit(DynamicListsState(data: state.data, isLoading: true));
    try {
      await _repository.delete(id);
      final lists = await _repository.listAll();
      emit(DynamicListsState(data: lists));
    } catch (error) {
      emit(DynamicListsState(data: state.data, errorMessage: error.toString()));
    }
  }
}
