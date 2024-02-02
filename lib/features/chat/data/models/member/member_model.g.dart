// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberModelImpl _$$MemberModelImplFromJson(Map<String, dynamic> json) =>
    _$MemberModelImpl(
      id: json['_id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      nickName: json['nickName'] as String,
      addedBy: json['addedBy'] as String,
      admin: json['admin'] as bool,
      seenMessage: json['seenMessage'] as String,
    );

Map<String, dynamic> _$$MemberModelImplToJson(_$MemberModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'nickName': instance.nickName,
      'addedBy': instance.addedBy,
      'admin': instance.admin,
      'seenMessage': instance.seenMessage,
    };
