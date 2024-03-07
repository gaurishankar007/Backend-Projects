// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_navigation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingNavigationModel {
  int get id => throw _privateConstructorUsedError;
  IconData get iconData => throw _privateConstructorUsedError;
  Color get backgroundColor => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get routePath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingNavigationModelCopyWith<SettingNavigationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingNavigationModelCopyWith<$Res> {
  factory $SettingNavigationModelCopyWith(SettingNavigationModel value,
          $Res Function(SettingNavigationModel) then) =
      _$SettingNavigationModelCopyWithImpl<$Res, SettingNavigationModel>;
  @useResult
  $Res call(
      {int id,
      IconData iconData,
      Color backgroundColor,
      String title,
      String subtitle,
      String value,
      String routePath});
}

/// @nodoc
class _$SettingNavigationModelCopyWithImpl<$Res,
        $Val extends SettingNavigationModel>
    implements $SettingNavigationModelCopyWith<$Res> {
  _$SettingNavigationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? iconData = null,
    Object? backgroundColor = null,
    Object? title = null,
    Object? subtitle = null,
    Object? value = null,
    Object? routePath = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      iconData: null == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      routePath: null == routePath
          ? _value.routePath
          : routePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingNavigationModelImplCopyWith<$Res>
    implements $SettingNavigationModelCopyWith<$Res> {
  factory _$$SettingNavigationModelImplCopyWith(
          _$SettingNavigationModelImpl value,
          $Res Function(_$SettingNavigationModelImpl) then) =
      __$$SettingNavigationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      IconData iconData,
      Color backgroundColor,
      String title,
      String subtitle,
      String value,
      String routePath});
}

/// @nodoc
class __$$SettingNavigationModelImplCopyWithImpl<$Res>
    extends _$SettingNavigationModelCopyWithImpl<$Res,
        _$SettingNavigationModelImpl>
    implements _$$SettingNavigationModelImplCopyWith<$Res> {
  __$$SettingNavigationModelImplCopyWithImpl(
      _$SettingNavigationModelImpl _value,
      $Res Function(_$SettingNavigationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? iconData = null,
    Object? backgroundColor = null,
    Object? title = null,
    Object? subtitle = null,
    Object? value = null,
    Object? routePath = null,
  }) {
    return _then(_$SettingNavigationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      iconData: null == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      routePath: null == routePath
          ? _value.routePath
          : routePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SettingNavigationModelImpl implements _SettingNavigationModel {
  const _$SettingNavigationModelImpl(
      {required this.id,
      required this.iconData,
      required this.backgroundColor,
      required this.title,
      required this.subtitle,
      required this.value,
      required this.routePath});

  @override
  final int id;
  @override
  final IconData iconData;
  @override
  final Color backgroundColor;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String value;
  @override
  final String routePath;

  @override
  String toString() {
    return 'SettingNavigationModel(id: $id, iconData: $iconData, backgroundColor: $backgroundColor, title: $title, subtitle: $subtitle, value: $value, routePath: $routePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingNavigationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.routePath, routePath) ||
                other.routePath == routePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, iconData, backgroundColor,
      title, subtitle, value, routePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingNavigationModelImplCopyWith<_$SettingNavigationModelImpl>
      get copyWith => __$$SettingNavigationModelImplCopyWithImpl<
          _$SettingNavigationModelImpl>(this, _$identity);
}

abstract class _SettingNavigationModel implements SettingNavigationModel {
  const factory _SettingNavigationModel(
      {required final int id,
      required final IconData iconData,
      required final Color backgroundColor,
      required final String title,
      required final String subtitle,
      required final String value,
      required final String routePath}) = _$SettingNavigationModelImpl;

  @override
  int get id;
  @override
  IconData get iconData;
  @override
  Color get backgroundColor;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get value;
  @override
  String get routePath;
  @override
  @JsonKey(ignore: true)
  _$$SettingNavigationModelImplCopyWith<_$SettingNavigationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
