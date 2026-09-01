import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_def.freezed.dart';
part 'category_def.g.dart';

@freezed
abstract class CategoryDef with _$CategoryDef {
  const factory CategoryDef({
    required String key,
    required String displayName,
    required String valueType, // 'multiSelectTags' | 'singleSelect' | 'boolean' | 'numericRange' | 'location' | 'text'
    @Default([]) List<String> availableOptions,
  }) = _CategoryDef;

  factory CategoryDef.fromJson(Map<String, dynamic> json) => _$CategoryDefFromJson(json);
}
