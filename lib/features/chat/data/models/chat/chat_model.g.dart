// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      id: json['_id'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      profilePic: json['profilePic'] as String,
      lastMessage:
          MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      group: json['group'] as bool,
      creator: json['creator'] as String,
      theme: json['theme'] as String,
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'members': instance.members,
      'name': instance.name,
      'profilePic': instance.profilePic,
      'lastMessage': instance.lastMessage,
      'group': instance.group,
      'creator': instance.creator,
      'theme': instance.theme,
    };
