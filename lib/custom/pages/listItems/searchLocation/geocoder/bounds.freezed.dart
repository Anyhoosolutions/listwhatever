// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bounds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Bounds _$BoundsFromJson(Map<String, dynamic> json) {
  return _Bounds.fromJson(json);
}

/// @nodoc
mixin _$Bounds {
  LatLong get northeast => throw _privateConstructorUsedError;
  LatLong get southwest => throw _privateConstructorUsedError;

  /// Serializes this Bounds to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoundsCopyWith<Bounds> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoundsCopyWith<$Res> {
  factory $BoundsCopyWith(Bounds value, $Res Function(Bounds) then) =
      _$BoundsCopyWithImpl<$Res, Bounds>;
  @useResult
  $Res call({LatLong northeast, LatLong southwest});

  $LatLongCopyWith<$Res> get northeast;
  $LatLongCopyWith<$Res> get southwest;
}

/// @nodoc
class _$BoundsCopyWithImpl<$Res, $Val extends Bounds>
    implements $BoundsCopyWith<$Res> {
  _$BoundsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? northeast = null,
    Object? southwest = null,
  }) {
    return _then(_value.copyWith(
      northeast: null == northeast
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LatLong,
      southwest: null == southwest
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LatLong,
    ) as $Val);
  }

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLongCopyWith<$Res> get northeast {
    return $LatLongCopyWith<$Res>(_value.northeast, (value) {
      return _then(_value.copyWith(northeast: value) as $Val);
    });
  }

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLongCopyWith<$Res> get southwest {
    return $LatLongCopyWith<$Res>(_value.southwest, (value) {
      return _then(_value.copyWith(southwest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BoundsImplCopyWith<$Res> implements $BoundsCopyWith<$Res> {
  factory _$$BoundsImplCopyWith(
          _$BoundsImpl value, $Res Function(_$BoundsImpl) then) =
      __$$BoundsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLong northeast, LatLong southwest});

  @override
  $LatLongCopyWith<$Res> get northeast;
  @override
  $LatLongCopyWith<$Res> get southwest;
}

/// @nodoc
class __$$BoundsImplCopyWithImpl<$Res>
    extends _$BoundsCopyWithImpl<$Res, _$BoundsImpl>
    implements _$$BoundsImplCopyWith<$Res> {
  __$$BoundsImplCopyWithImpl(
      _$BoundsImpl _value, $Res Function(_$BoundsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? northeast = null,
    Object? southwest = null,
  }) {
    return _then(_$BoundsImpl(
      northeast: null == northeast
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LatLong,
      southwest: null == southwest
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LatLong,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoundsImpl implements _Bounds {
  _$BoundsImpl({required this.northeast, required this.southwest});

  factory _$BoundsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoundsImplFromJson(json);

  @override
  final LatLong northeast;
  @override
  final LatLong southwest;

  @override
  String toString() {
    return 'Bounds(northeast: $northeast, southwest: $southwest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoundsImpl &&
            (identical(other.northeast, northeast) ||
                other.northeast == northeast) &&
            (identical(other.southwest, southwest) ||
                other.southwest == southwest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, northeast, southwest);

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoundsImplCopyWith<_$BoundsImpl> get copyWith =>
      __$$BoundsImplCopyWithImpl<_$BoundsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoundsImplToJson(
      this,
    );
  }
}

abstract class _Bounds implements Bounds {
  factory _Bounds(
      {required final LatLong northeast,
      required final LatLong southwest}) = _$BoundsImpl;

  factory _Bounds.fromJson(Map<String, dynamic> json) = _$BoundsImpl.fromJson;

  @override
  LatLong get northeast;
  @override
  LatLong get southwest;

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoundsImplCopyWith<_$BoundsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
