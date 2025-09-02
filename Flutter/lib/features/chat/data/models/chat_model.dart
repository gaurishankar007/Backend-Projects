import '../../../message/data/models/message_model.dart';
import '../../domain/entities/chat.dart';
import 'member_model.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.members,
    required super.name,
    required super.profile,
    required super.lastMessage,
    required super.group,
    required super.creator,
    required super.theme,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['_id'] as String,
        members: (json['members'] as List<dynamic>)
            .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String,
        profile: json['profile'] as String,
        lastMessage: MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
        group: json['group'] as bool,
        creator: json['creator'] as String,
        theme: json['theme'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'members': members,
        'name': name,
        'profile': profile,
        'lastMessage': lastMessage,
        'group': group,
        'creator': creator,
        'theme': theme,
      };
}
