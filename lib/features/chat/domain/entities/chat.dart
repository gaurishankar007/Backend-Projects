import '../../../message/domain/entities/message.dart';
import 'member.dart';

class Chat {
  final String id;
  final List<Member> members;
  final String name;
  final String profilePic;
  final Message lastMessage;
  final bool group;
  final String creator;
  final String theme;

  const Chat({
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
