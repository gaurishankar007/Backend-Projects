import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../message/data/models/message/message_model.dart';
import '../../../domain/entities/chat_entity.dart';
import '../member/member_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel extends ChatEntity with _$ChatModel {
  const factory ChatModel({
    required String id,
    required List<MemberModel> members,
    required String name,
    required String profilePic,
    required MessageModel lastMessage,
    required bool group,
    required String creator,
    required String theme,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$$ChatModelImplFromJson(json);
}
