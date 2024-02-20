// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_short_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageRepliedUponModelImpl _$$MessageRepliedUponModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageRepliedUponModelImpl(
      messageId: json['_id'] as String,
      content: json['content'] as String,
      contentType: json['contentType'] as String,
    );

Map<String, dynamic> _$$MessageRepliedUponModelImplToJson(
        _$MessageRepliedUponModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.messageId,
      'content': instance.content,
      'contentType': instance.contentType,
    };
