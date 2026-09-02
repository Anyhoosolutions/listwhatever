// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListItem {

 String get id; String get title; String? get notes;@CategoryValuesConverter() Map<String, List<String>> get categoryValues; String? get address; Map<String, double>? get latlong; DateTime get createdAt; DateTime get updatedAt; ListItemIcon? get icon; ListItemIconBackground? get iconBackground; String? get imageUrl;
/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListItemCopyWith<ListItem> get copyWith => _$ListItemCopyWithImpl<ListItem>(this as ListItem, _$identity);

  /// Serializes this ListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.categoryValues, categoryValues)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.latlong, latlong)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackground, iconBackground) || other.iconBackground == iconBackground)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,notes,const DeepCollectionEquality().hash(categoryValues),address,const DeepCollectionEquality().hash(latlong),createdAt,updatedAt,icon,iconBackground,imageUrl);

@override
String toString() {
  return 'ListItem(id: $id, title: $title, notes: $notes, categoryValues: $categoryValues, address: $address, latlong: $latlong, createdAt: $createdAt, updatedAt: $updatedAt, icon: $icon, iconBackground: $iconBackground, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ListItemCopyWith<$Res>  {
  factory $ListItemCopyWith(ListItem value, $Res Function(ListItem) _then) = _$ListItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? notes,@CategoryValuesConverter() Map<String, List<String>> categoryValues, String? address, Map<String, double>? latlong, DateTime createdAt, DateTime updatedAt, ListItemIcon? icon, ListItemIconBackground? iconBackground, String? imageUrl
});




}
/// @nodoc
class _$ListItemCopyWithImpl<$Res>
    implements $ListItemCopyWith<$Res> {
  _$ListItemCopyWithImpl(this._self, this._then);

  final ListItem _self;
  final $Res Function(ListItem) _then;

/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? notes = freezed,Object? categoryValues = null,Object? address = freezed,Object? latlong = freezed,Object? createdAt = null,Object? updatedAt = null,Object? icon = freezed,Object? iconBackground = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,categoryValues: null == categoryValues ? _self.categoryValues : categoryValues // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latlong: freezed == latlong ? _self.latlong : latlong // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as ListItemIcon?,iconBackground: freezed == iconBackground ? _self.iconBackground : iconBackground // ignore: cast_nullable_to_non_nullable
as ListItemIconBackground?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListItem].
extension ListItemPatterns on ListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListItem value)  $default,){
final _that = this;
switch (_that) {
case _ListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListItem value)?  $default,){
final _that = this;
switch (_that) {
case _ListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? notes, @CategoryValuesConverter()  Map<String, List<String>> categoryValues,  String? address,  Map<String, double>? latlong,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListItem() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.categoryValues,_that.address,_that.latlong,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? notes, @CategoryValuesConverter()  Map<String, List<String>> categoryValues,  String? address,  Map<String, double>? latlong,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ListItem():
return $default(_that.id,_that.title,_that.notes,_that.categoryValues,_that.address,_that.latlong,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? notes, @CategoryValuesConverter()  Map<String, List<String>> categoryValues,  String? address,  Map<String, double>? latlong,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ListItem() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.categoryValues,_that.address,_that.latlong,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListItem extends ListItem {
  const _ListItem({required this.id, required this.title, this.notes = null, @CategoryValuesConverter() required final  Map<String, List<String>> categoryValues, this.address = null, final  Map<String, double>? latlong = null, required this.createdAt, required this.updatedAt, this.icon = null, this.iconBackground = null, this.imageUrl}): _categoryValues = categoryValues,_latlong = latlong,super._();
  factory _ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  String? notes;
 final  Map<String, List<String>> _categoryValues;
@override@CategoryValuesConverter() Map<String, List<String>> get categoryValues {
  if (_categoryValues is EqualUnmodifiableMapView) return _categoryValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryValues);
}

@override@JsonKey() final  String? address;
 final  Map<String, double>? _latlong;
@override@JsonKey() Map<String, double>? get latlong {
  final value = _latlong;
  if (value == null) return null;
  if (_latlong is EqualUnmodifiableMapView) return _latlong;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  ListItemIcon? icon;
@override@JsonKey() final  ListItemIconBackground? iconBackground;
@override final  String? imageUrl;

/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListItemCopyWith<_ListItem> get copyWith => __$ListItemCopyWithImpl<_ListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._categoryValues, _categoryValues)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._latlong, _latlong)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackground, iconBackground) || other.iconBackground == iconBackground)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,notes,const DeepCollectionEquality().hash(_categoryValues),address,const DeepCollectionEquality().hash(_latlong),createdAt,updatedAt,icon,iconBackground,imageUrl);

@override
String toString() {
  return 'ListItem(id: $id, title: $title, notes: $notes, categoryValues: $categoryValues, address: $address, latlong: $latlong, createdAt: $createdAt, updatedAt: $updatedAt, icon: $icon, iconBackground: $iconBackground, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ListItemCopyWith<$Res> implements $ListItemCopyWith<$Res> {
  factory _$ListItemCopyWith(_ListItem value, $Res Function(_ListItem) _then) = __$ListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? notes,@CategoryValuesConverter() Map<String, List<String>> categoryValues, String? address, Map<String, double>? latlong, DateTime createdAt, DateTime updatedAt, ListItemIcon? icon, ListItemIconBackground? iconBackground, String? imageUrl
});




}
/// @nodoc
class __$ListItemCopyWithImpl<$Res>
    implements _$ListItemCopyWith<$Res> {
  __$ListItemCopyWithImpl(this._self, this._then);

  final _ListItem _self;
  final $Res Function(_ListItem) _then;

/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? notes = freezed,Object? categoryValues = null,Object? address = freezed,Object? latlong = freezed,Object? createdAt = null,Object? updatedAt = null,Object? icon = freezed,Object? iconBackground = freezed,Object? imageUrl = freezed,}) {
  return _then(_ListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,categoryValues: null == categoryValues ? _self._categoryValues : categoryValues // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latlong: freezed == latlong ? _self._latlong : latlong // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as ListItemIcon?,iconBackground: freezed == iconBackground ? _self.iconBackground : iconBackground // ignore: cast_nullable_to_non_nullable
as ListItemIconBackground?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
