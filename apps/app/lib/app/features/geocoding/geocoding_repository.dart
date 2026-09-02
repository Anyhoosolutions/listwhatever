import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';

abstract class GeocodingRepository {
  Future<List<GeocodingResult>> search(String query);
}
