// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['_id'] as String,
      chat: json['chat'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      contentType: $enumDecode(_$ContentTypeEnumMap, json['contentType']),
      reactions: (json['reactions'] as List<dynamic>)
          .map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      repliedTo: MessageRepliedUponModel.fromJson(json['repliedTo']),
      pinned: json['pinned'] as bool,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'chat': instance.chat,
      'sender': instance.sender,
      'content': instance.content,
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'reactions': instance.reactions,
      'repliedTo': instance.repliedTo,
      'pinned': instance.pinned,
    };

const _$ContentTypeEnumMap = {
  ContentType.text: 'text',
  ContentType.url: 'url',
  ContentType.image: 'image',
  ContentType.audio: 'audio',
  ContentType.video: 'video',
  ContentType.activity: 'activity',
};
