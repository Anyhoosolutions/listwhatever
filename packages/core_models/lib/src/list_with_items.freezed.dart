// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_with_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListWithItems {

 String get id; String get ownerId; String get title; String get description; String get visibility;// 'private' | 'shared' | 'public'
 List<UserId> get collaboratorIds; List<ListItem> get items; bool get hasLocations; DateTime get createdAt; DateTime get updatedAt; ListItemIcon? get icon; ListItemIconBackground? get iconBackground;
/// Create a copy of ListWithItems
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListWithItemsCopyWith<ListWithItems> get copyWith => _$ListWithItemsCopyWithImpl<ListWithItems>(this as ListWithItems, _$identity);

  /// Serializes this ListWithItems to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListWithItems&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other.collaboratorIds, collaboratorIds)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.hasLocations, hasLocations) || other.hasLocations == hasLocations)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackground, iconBackground) || other.iconBackground == iconBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,title,description,visibility,const DeepCollectionEquality().hash(collaboratorIds),const DeepCollectionEquality().hash(items),hasLocations,createdAt,updatedAt,icon,iconBackground);

@override
String toString() {
  return 'ListWithItems(id: $id, ownerId: $ownerId, title: $title, description: $description, visibility: $visibility, collaboratorIds: $collaboratorIds, items: $items, hasLocations: $hasLocations, createdAt: $createdAt, updatedAt: $updatedAt, icon: $icon, iconBackground: $iconBackground)';
}


}

/// @nodoc
abstract mixin class $ListWithItemsCopyWith<$Res>  {
  factory $ListWithItemsCopyWith(ListWithItems value, $Res Function(ListWithItems) _then) = _$ListWithItemsCopyWithImpl;
@useResult
$Res call({
 String id, String ownerId, String title, String description, String visibility, List<UserId> collaboratorIds, List<ListItem> items, bool hasLocations, DateTime createdAt, DateTime updatedAt, ListItemIcon? icon, ListItemIconBackground? iconBackground
});




}
/// @nodoc
class _$ListWithItemsCopyWithImpl<$Res>
    implements $ListWithItemsCopyWith<$Res> {
  _$ListWithItemsCopyWithImpl(this._self, this._then);

  final ListWithItems _self;
  final $Res Function(ListWithItems) _then;

/// Create a copy of ListWithItems
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? title = null,Object? description = null,Object? visibility = null,Object? collaboratorIds = null,Object? items = null,Object? hasLocations = null,Object? createdAt = null,Object? updatedAt = null,Object? icon = freezed,Object? iconBackground = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,collaboratorIds: null == collaboratorIds ? _self.collaboratorIds : collaboratorIds // ignore: cast_nullable_to_non_nullable
as List<UserId>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ListItem>,hasLocations: null == hasLocations ? _self.hasLocations : hasLocations // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as ListItemIcon?,iconBackground: freezed == iconBackground ? _self.iconBackground : iconBackground // ignore: cast_nullable_to_non_nullable
as ListItemIconBackground?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListWithItems].
extension ListWithItemsPatterns on ListWithItems {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListWithItems value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListWithItems() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListWithItems value)  $default,){
final _that = this;
switch (_that) {
case _ListWithItems():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListWithItems value)?  $default,){
final _that = this;
switch (_that) {
case _ListWithItems() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerId,  String title,  String description,  String visibility,  List<UserId> collaboratorIds,  List<ListItem> items,  bool hasLocations,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListWithItems() when $default != null:
return $default(_that.id,_that.ownerId,_that.title,_that.description,_that.visibility,_that.collaboratorIds,_that.items,_that.hasLocations,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerId,  String title,  String description,  String visibility,  List<UserId> collaboratorIds,  List<ListItem> items,  bool hasLocations,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground)  $default,) {final _that = this;
switch (_that) {
case _ListWithItems():
return $default(_that.id,_that.ownerId,_that.title,_that.description,_that.visibility,_that.collaboratorIds,_that.items,_that.hasLocations,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerId,  String title,  String description,  String visibility,  List<UserId> collaboratorIds,  List<ListItem> items,  bool hasLocations,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground)?  $default,) {final _that = this;
switch (_that) {
case _ListWithItems() when $default != null:
return $default(_that.id,_that.ownerId,_that.title,_that.description,_that.visibility,_that.collaboratorIds,_that.items,_that.hasLocations,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListWithItems implements ListWithItems {
  const _ListWithItems({required this.id, required this.ownerId, required this.title, required this.description, required this.visibility, final  List<UserId> collaboratorIds = const [], required final  List<ListItem> items, this.hasLocations = false, required this.createdAt, required this.updatedAt, this.icon = null, this.iconBackground = null}): _collaboratorIds = collaboratorIds,_items = items;
  factory _ListWithItems.fromJson(Map<String, dynamic> json) => _$ListWithItemsFromJson(json);

@override final  String id;
@override final  String ownerId;
@override final  String title;
@override final  String description;
@override final  String visibility;
// 'private' | 'shared' | 'public'
 final  List<UserId> _collaboratorIds;
// 'private' | 'shared' | 'public'
@override@JsonKey() List<UserId> get collaboratorIds {
  if (_collaboratorIds is EqualUnmodifiableListView) return _collaboratorIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collaboratorIds);
}

 final  List<ListItem> _items;
@override List<ListItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool hasLocations;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  ListItemIcon? icon;
@override@JsonKey() final  ListItemIconBackground? iconBackground;

/// Create a copy of ListWithItems
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListWithItemsCopyWith<_ListWithItems> get copyWith => __$ListWithItemsCopyWithImpl<_ListWithItems>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListWithItemsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListWithItems&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other._collaboratorIds, _collaboratorIds)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.hasLocations, hasLocations) || other.hasLocations == hasLocations)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackground, iconBackground) || other.iconBackground == iconBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,title,description,visibility,const DeepCollectionEquality().hash(_collaboratorIds),const DeepCollectionEquality().hash(_items),hasLocations,createdAt,updatedAt,icon,iconBackground);

@override
String toString() {
  return 'ListWithItems(id: $id, ownerId: $ownerId, title: $title, description: $description, visibility: $visibility, collaboratorIds: $collaboratorIds, items: $items, hasLocations: $hasLocations, createdAt: $createdAt, updatedAt: $updatedAt, icon: $icon, iconBackground: $iconBackground)';
}


}

/// @nodoc
abstract mixin class _$ListWithItemsCopyWith<$Res> implements $ListWithItemsCopyWith<$Res> {
  factory _$ListWithItemsCopyWith(_ListWithItems value, $Res Function(_ListWithItems) _then) = __$ListWithItemsCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerId, String title, String description, String visibility, List<UserId> collaboratorIds, List<ListItem> items, bool hasLocations, DateTime createdAt, DateTime updatedAt, ListItemIcon? icon, ListItemIconBackground? iconBackground
});




}
/// @nodoc
class __$ListWithItemsCopyWithImpl<$Res>
    implements _$ListWithItemsCopyWith<$Res> {
  __$ListWithItemsCopyWithImpl(this._self, this._then);

  final _ListWithItems _self;
  final $Res Function(_ListWithItems) _then;

/// Create a copy of ListWithItems
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? title = null,Object? description = null,Object? visibility = null,Object? collaboratorIds = null,Object? items = null,Object? hasLocations = null,Object? createdAt = null,Object? updatedAt = null,Object? icon = freezed,Object? iconBackground = freezed,}) {
  return _then(_ListWithItems(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,collaboratorIds: null == collaboratorIds ? _self._collaboratorIds : collaboratorIds // ignore: cast_nullable_to_non_nullable
as List<UserId>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ListItem>,hasLocations: null == hasLocations ? _self.hasLocations : hasLocations // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as ListItemIcon?,iconBackground: freezed == iconBackground ? _self.iconBackground : iconBackground // ignore: cast_nullable_to_non_nullable
as ListItemIconBackground?,
  ));
}


}

// dart format on
