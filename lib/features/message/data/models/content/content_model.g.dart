// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentModelImpl _$$ContentModelImplFromJson(Map<String, dynamic> json) =>
    _$ContentModelImpl(
      messageId: json['messageId'] as String,
      content: json['content'] as String,
      contentType: json['contentType'] as String,
    );

Map<String, dynamic> _$$ContentModelImplToJson(_$ContentModelImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'content': instance.content,
      'contentType': instance.contentType,
    };
