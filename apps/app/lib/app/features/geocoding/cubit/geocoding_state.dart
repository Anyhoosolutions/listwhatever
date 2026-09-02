import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';
import 'package:listwhatever/shared/cubit_helpers/loadable_state.dart';

class GeocodingState extends LoadableState<List<GeocodingResult>> {
  const GeocodingState({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });
}
