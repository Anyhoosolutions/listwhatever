import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_of_things.freezed.dart';
part 'list_of_things.g.dart';

enum ShareType {
  viewer,
  editor,
}

enum FilterType {
  regular._('Values'),
  numericRange._('Numeric range'),
  dateRange._('Date range'),
  timeOfDayRange._('Time range');

  const FilterType._(this.value);
  final String value;
}

@freezed
class ListOfThings with _$ListOfThings {
  const factory ListOfThings({
    required String? id,
    required String name,
    required bool withMap,
    required bool withDates,
    required bool withTimes,
    required bool shared,
    required Map<String, ShareType> sharedWith,
    required String? ownerId,
    @JsonKey(fromJson: fromTimestamp, toJson: toTimestamp) required DateTime createdAt,
    @Default({}) Map<String, FilterType> filterTypes,
    @Default(null) String? imageFilename,
    @Default(null) String? shareCodeForViewer,
    @Default(null) String? shareCodeForEditor,
    @Default(ShareType.viewer) ShareType shareType,
  }) = _ListOfThings;

  factory ListOfThings.fromJson(Map<String, Object?> json) => _$ListOfThingsFromJson(json);
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
