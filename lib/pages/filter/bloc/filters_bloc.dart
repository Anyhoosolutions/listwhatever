import 'package:bloc/bloc.dart';
import 'package:listwhatever/pages/filter/bloc/filters_event.dart';
import 'package:listwhatever/pages/filter/bloc/filters_state.dart';
import 'package:listwhatever/pages/list/models/filters.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersInitial(filters: Filters())) {
    on<UpdateFilters>(_onUpdateFilters);
  }

  Future<void> _onUpdateFilters(
    UpdateFilters event,
    Emitter<FiltersState> emit,
  ) async {
    emit(FiltersLoading());

    emit(FiltersLoaded(filters: event.filters));
  }
}
