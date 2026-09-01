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

 String get id; String get title; String get notes; Map<String, dynamic> get categoryValues;// Keys match CategoryDef.key
 String? get address; LatLong? get latlong; DateTime get createdAt; DateTime get updatedAt; ListItemIcon? get icon; ListItemIconBackground? get iconBackground; String? get imageUrl;
/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListItemCopyWith<ListItem> get copyWith => _$ListItemCopyWithImpl<ListItem>(this as ListItem, _$identity);

  /// Serializes this ListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.categoryValues, categoryValues)&&(identical(other.address, address) || other.address == address)&&(identical(other.latlong, latlong) || other.latlong == latlong)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackground, iconBackground) || other.iconBackground == iconBackground)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,notes,const DeepCollectionEquality().hash(categoryValues),address,latlong,createdAt,updatedAt,icon,iconBackground,imageUrl);

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
 String id, String title, String notes, Map<String, dynamic> categoryValues, String? address, LatLong? latlong, DateTime createdAt, DateTime updatedAt, ListItemIcon? icon, ListItemIconBackground? iconBackground, String? imageUrl
});


$LatLongCopyWith<$Res>? get latlong;

}
/// @nodoc
class _$ListItemCopyWithImpl<$Res>
    implements $ListItemCopyWith<$Res> {
  _$ListItemCopyWithImpl(this._self, this._then);

  final ListItem _self;
  final $Res Function(ListItem) _then;

/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? notes = null,Object? categoryValues = null,Object? address = freezed,Object? latlong = freezed,Object? createdAt = null,Object? updatedAt = null,Object? icon = freezed,Object? iconBackground = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,categoryValues: null == categoryValues ? _self.categoryValues : categoryValues // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latlong: freezed == latlong ? _self.latlong : latlong // ignore: cast_nullable_to_non_nullable
as LatLong?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as ListItemIcon?,iconBackground: freezed == iconBackground ? _self.iconBackground : iconBackground // ignore: cast_nullable_to_non_nullable
as ListItemIconBackground?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatLongCopyWith<$Res>? get latlong {
    if (_self.latlong == null) {
    return null;
  }

  return $LatLongCopyWith<$Res>(_self.latlong!, (value) {
    return _then(_self.copyWith(latlong: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String notes,  Map<String, dynamic> categoryValues,  String? address,  LatLong? latlong,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String notes,  Map<String, dynamic> categoryValues,  String? address,  LatLong? latlong,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground,  String? imageUrl)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String notes,  Map<String, dynamic> categoryValues,  String? address,  LatLong? latlong,  DateTime createdAt,  DateTime updatedAt,  ListItemIcon? icon,  ListItemIconBackground? iconBackground,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ListItem() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.categoryValues,_that.address,_that.latlong,_that.createdAt,_that.updatedAt,_that.icon,_that.iconBackground,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListItem implements ListItem {
  const _ListItem({required this.id, required this.title, required this.notes, required final  Map<String, dynamic> categoryValues, this.address, this.latlong, required this.createdAt, required this.updatedAt, this.icon, this.iconBackground, this.imageUrl}): _categoryValues = categoryValues;
  factory _ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  String notes;
 final  Map<String, dynamic> _categoryValues;
@override Map<String, dynamic> get categoryValues {
  if (_categoryValues is EqualUnmodifiableMapView) return _categoryValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryValues);
}

// Keys match CategoryDef.key
@override final  String? address;
@override final  LatLong? latlong;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  ListItemIcon? icon;
@override final  ListItemIconBackground? iconBackground;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._categoryValues, _categoryValues)&&(identical(other.address, address) || other.address == address)&&(identical(other.latlong, latlong) || other.latlong == latlong)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackground, iconBackground) || other.iconBackground == iconBackground)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,notes,const DeepCollectionEquality().hash(_categoryValues),address,latlong,createdAt,updatedAt,icon,iconBackground,imageUrl);

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
 String id, String title, String notes, Map<String, dynamic> categoryValues, String? address, LatLong? latlong, DateTime createdAt, DateTime updatedAt, ListItemIcon? icon, ListItemIconBackground? iconBackground, String? imageUrl
});


@override $LatLongCopyWith<$Res>? get latlong;

}
/// @nodoc
class __$ListItemCopyWithImpl<$Res>
    implements _$ListItemCopyWith<$Res> {
  __$ListItemCopyWithImpl(this._self, this._then);

  final _ListItem _self;
  final $Res Function(_ListItem) _then;

/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? notes = null,Object? categoryValues = null,Object? address = freezed,Object? latlong = freezed,Object? createdAt = null,Object? updatedAt = null,Object? icon = freezed,Object? iconBackground = freezed,Object? imageUrl = freezed,}) {
  return _then(_ListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,categoryValues: null == categoryValues ? _self._categoryValues : categoryValues // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latlong: freezed == latlong ? _self.latlong : latlong // ignore: cast_nullable_to_non_nullable
as LatLong?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as ListItemIcon?,iconBackground: freezed == iconBackground ? _self.iconBackground : iconBackground // ignore: cast_nullable_to_non_nullable
as ListItemIconBackground?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatLongCopyWith<$Res>? get latlong {
    if (_self.latlong == null) {
    return null;
  }

  return $LatLongCopyWith<$Res>(_self.latlong!, (value) {
    return _then(_self.copyWith(latlong: value));
  });
}
}

// dart format on
