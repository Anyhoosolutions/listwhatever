// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_bar_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppBarAction {
  String get title => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  void Function() get callback => throw _privateConstructorUsedError;
  bool get overflow => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppBarActionCopyWith<AppBarAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBarActionCopyWith<$Res> {
  factory $AppBarActionCopyWith(
          AppBarAction value, $Res Function(AppBarAction) then) =
      _$AppBarActionCopyWithImpl<$Res, AppBarAction>;
  @useResult
  $Res call(
      {String title, IconData icon, void Function() callback, bool overflow});
}

/// @nodoc
class _$AppBarActionCopyWithImpl<$Res, $Val extends AppBarAction>
    implements $AppBarActionCopyWith<$Res> {
  _$AppBarActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? icon = null,
    Object? callback = null,
    Object? overflow = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      callback: null == callback
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(),
      overflow: null == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppBarActionCopyWith<$Res>
    implements $AppBarActionCopyWith<$Res> {
  factory _$$_AppBarActionCopyWith(
          _$_AppBarAction value, $Res Function(_$_AppBarAction) then) =
      __$$_AppBarActionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title, IconData icon, void Function() callback, bool overflow});
}

/// @nodoc
class __$$_AppBarActionCopyWithImpl<$Res>
    extends _$AppBarActionCopyWithImpl<$Res, _$_AppBarAction>
    implements _$$_AppBarActionCopyWith<$Res> {
  __$$_AppBarActionCopyWithImpl(
      _$_AppBarAction _value, $Res Function(_$_AppBarAction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? icon = null,
    Object? callback = null,
    Object? overflow = null,
  }) {
    return _then(_$_AppBarAction(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      callback: null == callback
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(),
      overflow: null == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AppBarAction implements _AppBarAction {
  _$_AppBarAction(
      {required this.title,
      required this.icon,
      required this.callback,
      required this.overflow});

  @override
  final String title;
  @override
  final IconData icon;
  @override
  final void Function() callback;
  @override
  final bool overflow;

  @override
  String toString() {
    return 'AppBarAction(title: $title, icon: $icon, callback: $callback, overflow: $overflow)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppBarAction &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.callback, callback) ||
                other.callback == callback) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, icon, callback, overflow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppBarActionCopyWith<_$_AppBarAction> get copyWith =>
      __$$_AppBarActionCopyWithImpl<_$_AppBarAction>(this, _$identity);
}

abstract class _AppBarAction implements AppBarAction {
  factory _AppBarAction(
      {required final String title,
      required final IconData icon,
      required final void Function() callback,
      required final bool overflow}) = _$_AppBarAction;

  @override
  String get title;
  @override
  IconData get icon;
  @override
  void Function() get callback;
  @override
  bool get overflow;
  @override
  @JsonKey(ignore: true)
  _$$_AppBarActionCopyWith<_$_AppBarAction> get copyWith =>
      throw _privateConstructorUsedError;
}