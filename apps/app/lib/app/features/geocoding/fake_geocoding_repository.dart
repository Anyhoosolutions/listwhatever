import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_repository.dart';

class FakeGeocodingRepository implements GeocodingRepository {
  FakeGeocodingRepository({
    this.delay = const Duration(milliseconds: 250),
    List<GeocodingResult>? places,
  }) : _places = places ?? _defaultPlaces;

  final Duration delay;
  final List<GeocodingResult> _places;

  static const _defaultPlaces = [
    GeocodingResult(
      displayName: 'Los Angeles, CA, USA',
      latitude: 34.0522,
      longitude: -118.2437,
    ),
    GeocodingResult(
      displayName: 'Griffith Observatory, Los Angeles, CA, USA',
      latitude: 34.1184,
      longitude: -118.3004,
    ),
    GeocodingResult(
      displayName: 'Santa Monica Pier, Santa Monica, CA, USA',
      latitude: 34.0086,
      longitude: -118.4976,
    ),
    GeocodingResult(
      displayName: 'Stockholm, Sweden',
      latitude: 59.3293,
      longitude: 18.0686,
    ),
    GeocodingResult(
      displayName: 'Central Park, New York, NY, USA',
      latitude: 40.7829,
      longitude: -73.9654,
    ),
  ];

  @override
  Future<List<GeocodingResult>> search(String query) async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) {
      return const [];
    }
    return _places.where((place) => place.displayName.toLowerCase().contains(needle)).toList();
  }
}
