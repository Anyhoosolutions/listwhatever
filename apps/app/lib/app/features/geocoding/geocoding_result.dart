import 'package:equatable/equatable.dart';

class GeocodingResult extends Equatable {
  const GeocodingResult({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  final String displayName;
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [displayName, latitude, longitude];
}
