import 'package:core_models/src/category_def.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_list.freezed.dart';
part 'dynamic_list.g.dart';

@freezed
abstract class DynamicList with _$DynamicList {
  const factory DynamicList({
    required String id,
    required String ownerId,
    required String title,
    required String description,
    required String visibility, // 'private' | 'shared' | 'public'
    @Default([]) List<String> collaboratorIds,
    @Default([]) List<CategoryDef> categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DynamicList;

  factory DynamicList.fromJson(Map<String, dynamic> json) => _$DynamicListFromJson(json);
}
