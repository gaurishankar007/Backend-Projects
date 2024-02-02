import '../../../message/domain/entities/message_entity.dart';
import 'member_entity.dart';

class ChatEntity {
  final String id;
  final List<MemberEntity> members;
  final String name;
  final String profilePic;
  final MessageEntity lastMessage;
  final bool group;
  final String creator;
  final String theme;

  const ChatEntity({
    required this.id,
    required this.members,
    required this.name,
    required this.profilePic,
    required this.lastMessage,
    required this.group,
    required this.creator,
    required this.theme,
  });
}
