import 'package:freezed_annotation/freezed_annotation.dart';

part 'lat_long.freezed.dart';
part 'lat_long.g.dart';

// USE THIS AND THEN MAP TO Geopoint

@freezed
abstract class LatLong with _$LatLong {
  const factory LatLong({required double latitude, required double longitude}) = _LatLong;

  factory LatLong.fromJson(Map<String, dynamic> json) => _$LatLongFromJson(json);
}
