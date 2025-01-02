// ignore_for_file: invalid_annotation_target

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

@freezed
class ListItem with _$ListItem {
  const factory ListItem({
    required String? id,
    required String name,
    @Default(null) String? info,
    @Default([]) List<String> urls,
    @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp) @Default(null) DateTime? datetime,
    @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint) @Default(null) LatLng? latLong,
    @Default(null) String? address,
    @Default({}) Map<String, List<String>> categories,
    @Default(null) String? latestUpdateUser,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, Object?> json) => _$ListItemFromJson(json);
}

GeoPoint? _toJsonGeoPoint(LatLng? latLong) {
  if (latLong == null) {
    return null;
  }
  return GeoPoint(latLong.latitude, latLong.longitude);
}

LatLng? _fromJsonGeoPoint(GeoPoint? geoPoint) {
  if (geoPoint == null) {
    return null;
  }
  return LatLng(geoPoint.latitude, geoPoint.longitude);
}

DateTime? _fromTimestamp(Timestamp? timestamp) {
  if (timestamp == null) {
    return null;
  }
  return DateTime.fromMillisecondsSinceEpoch(
    timestamp.millisecondsSinceEpoch,
  );
}

Timestamp? _toTimestamp(DateTime? datetime) {
  if (datetime == null) {
    return null;
  }
  return Timestamp.fromMillisecondsSinceEpoch(
    datetime.millisecondsSinceEpoch,
  );
}
