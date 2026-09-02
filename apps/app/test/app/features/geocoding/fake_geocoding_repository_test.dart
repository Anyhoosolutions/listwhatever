import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/geocoding/fake_geocoding_repository.dart';

void main() {
  test('search matches places by display name', () async {
    final repository = FakeGeocodingRepository(delay: Duration.zero);

    final results = await repository.search('los angeles');

    expect(results.map((r) => r.displayName), [
      'Los Angeles, CA, USA',
      'Griffith Observatory, Los Angeles, CA, USA',
    ]);
  });

  test('search returns an empty list for a blank query', () async {
    final repository = FakeGeocodingRepository(delay: Duration.zero);

    expect(await repository.search('   '), isEmpty);
  });
}
