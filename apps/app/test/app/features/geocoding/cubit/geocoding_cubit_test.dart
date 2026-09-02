import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/geocoding/cubit/geocoding_cubit.dart';
import 'package:listwhatever/app/features/geocoding/fake_geocoding_repository.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_repository.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';

void main() {
  test('search returns matching places', () async {
    final cubit = GeocodingCubit(repository: FakeGeocodingRepository(delay: Duration.zero));
    addTearDown(cubit.close);

    await cubit.search('stockholm');

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.data, [
      const GeocodingResult(
        displayName: 'Stockholm, Sweden',
        latitude: 59.3293,
        longitude: 18.0686,
      ),
    ]);
  });

  test('search with a blank query clears results without loading', () async {
    final cubit = GeocodingCubit(repository: FakeGeocodingRepository(delay: Duration.zero));
    addTearDown(cubit.close);

    await cubit.search('park');
    await cubit.search('  ');

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.data, isEmpty);
  });

  test('search reports repository errors', () async {
    final cubit = GeocodingCubit(repository: _ThrowingGeocodingRepository());
    addTearDown(cubit.close);

    await cubit.search('los');

    expect(cubit.state.data, isNull);
    expect(cubit.state.errorMessage, contains('unavailable'));
  });
}

class _ThrowingGeocodingRepository implements GeocodingRepository {
  @override
  Future<List<GeocodingResult>> search(String query) async {
    throw Exception('unavailable');
  }
}
