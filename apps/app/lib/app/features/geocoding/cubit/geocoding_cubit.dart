import 'package:bloc/bloc.dart';
import 'package:listwhatever/app/features/geocoding/cubit/geocoding_state.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_repository.dart';

class GeocodingCubit extends Cubit<GeocodingState> {
  GeocodingCubit({required this._repository})
    : super(const GeocodingState(data: []));

  final GeocodingRepository _repository;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(const GeocodingState(data: []));
      return;
    }

    emit(const GeocodingState(isLoading: true));
    try {
      final results = await _repository.search(query);
      emit(GeocodingState(data: results));
    } catch (error) {
      emit(GeocodingState(errorMessage: error.toString()));
    }
  }

  void clear() {
    emit(const GeocodingState(data: []));
  }
}
