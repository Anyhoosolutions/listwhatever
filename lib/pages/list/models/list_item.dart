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
    @JsonKey(fromJson: fromMaybeTimestamp, toJson: toMaybeTimestamp) @Default(null) DateTime? datetime,
    @JsonKey(fromJson: fromJsonGeoPoint, toJson: toJsonGeoPoint) @Default(null) LatLng? latLong,
    @Default(null) String? address,
    @Default({}) Map<String, List<String>> categories,
    @Default(null) String? latestUpdateUser,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, Object?> json) => _$ListItemFromJson(json);
}

GeoPoint? toJsonGeoPoint(LatLng? latLong) {
  if (latLong == null) {
    return null;
  }
  return GeoPoint(latLong.latitude, latLong.longitude);
}

LatLng? fromJsonGeoPoint(GeoPoint? geoPoint) {
  if (geoPoint == null) {
    return null;
  }
  return LatLng(geoPoint.latitude, geoPoint.longitude);
}

DateTime? fromMaybeTimestamp(Timestamp? timestamp) {
  if (timestamp == null) {
    return null;
  }
  return fromTimestamp(timestamp);
}

Timestamp? toMaybeTimestamp(DateTime? datetime) {
  if (datetime == null) {
    return null;
  }
  return toTimestamp(datetime);
}

DateTime fromTimestamp(Timestamp timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(
    timestamp.millisecondsSinceEpoch,
  );
}

Timestamp toTimestamp(DateTime datetime) {
  return Timestamp.fromMillisecondsSinceEpoch(
    datetime.millisecondsSinceEpoch,
  );
}
