// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_short_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageRepliedUponModel _$MessageRepliedUponModelFromJson(
    Map<String, dynamic> json) {
  return _MessageRepliedUponModel.fromJson(json);
}

/// @nodoc
mixin _$MessageRepliedUponModel {
  @JsonKey(name: "_id")
  String get messageId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageRepliedUponModelCopyWith<MessageRepliedUponModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageRepliedUponModelCopyWith<$Res> {
  factory $MessageRepliedUponModelCopyWith(MessageRepliedUponModel value,
          $Res Function(MessageRepliedUponModel) then) =
      _$MessageRepliedUponModelCopyWithImpl<$Res, MessageRepliedUponModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String messageId,
      String content,
      String contentType});
}

/// @nodoc
class _$MessageRepliedUponModelCopyWithImpl<$Res,
        $Val extends MessageRepliedUponModel>
    implements $MessageRepliedUponModelCopyWith<$Res> {
  _$MessageRepliedUponModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? content = null,
    Object? contentType = null,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageRepliedUponModelImplCopyWith<$Res>
    implements $MessageRepliedUponModelCopyWith<$Res> {
  factory _$$MessageRepliedUponModelImplCopyWith(
          _$MessageRepliedUponModelImpl value,
          $Res Function(_$MessageRepliedUponModelImpl) then) =
      __$$MessageRepliedUponModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String messageId,
      String content,
      String contentType});
}

/// @nodoc
class __$$MessageRepliedUponModelImplCopyWithImpl<$Res>
    extends _$MessageRepliedUponModelCopyWithImpl<$Res,
        _$MessageRepliedUponModelImpl>
    implements _$$MessageRepliedUponModelImplCopyWith<$Res> {
  __$$MessageRepliedUponModelImplCopyWithImpl(
      _$MessageRepliedUponModelImpl _value,
      $Res Function(_$MessageRepliedUponModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? content = null,
    Object? contentType = null,
  }) {
    return _then(_$MessageRepliedUponModelImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageRepliedUponModelImpl implements _MessageRepliedUponModel {
  const _$MessageRepliedUponModelImpl(
      {@JsonKey(name: "_id") required this.messageId,
      required this.content,
      required this.contentType});

  factory _$MessageRepliedUponModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageRepliedUponModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String messageId;
  @override
  final String content;
  @override
  final String contentType;

  @override
  String toString() {
    return 'MessageRepliedUponModel(messageId: $messageId, content: $content, contentType: $contentType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageRepliedUponModelImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, content, contentType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageRepliedUponModelImplCopyWith<_$MessageRepliedUponModelImpl>
      get copyWith => __$$MessageRepliedUponModelImplCopyWithImpl<
          _$MessageRepliedUponModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageRepliedUponModelImplToJson(
      this,
    );
  }
}

abstract class _MessageRepliedUponModel implements MessageRepliedUponModel {
  const factory _MessageRepliedUponModel(
      {@JsonKey(name: "_id") required final String messageId,
      required final String content,
      required final String contentType}) = _$MessageRepliedUponModelImpl;

  factory _MessageRepliedUponModel.fromJson(Map<String, dynamic> json) =
      _$MessageRepliedUponModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get messageId;
  @override
  String get content;
  @override
  String get contentType;
  @override
  @JsonKey(ignore: true)
  _$$MessageRepliedUponModelImplCopyWith<_$MessageRepliedUponModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
