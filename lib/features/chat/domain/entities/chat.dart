import 'package:equatable/equatable.dart';

import '../../../message/domain/entities/message.dart';
import 'member.dart';

class Chat extends Equatable {
  final String id;
  final List<Member> members;
  final String name;
  final String profile;
  final Message lastMessage;
  final bool group;
  final String creator;
  final String theme;

  const Chat({
    required this.id,
    required this.members,
    required this.name,
    required this.profile,
    required this.lastMessage,
    required this.group,
    required this.creator,
    required this.theme,
  });

  Chat copyWith({
    String? id,
    List<Member>? members,
    String? name,
    String? profile,
    Message? lastMessage,
    bool? group,
    String? creator,
    String? theme,
  }) =>
      Chat(
        id: id ?? this.id,
        members: members ?? this.members,
        name: name ?? this.name,
        profile: profile ?? this.profile,
        lastMessage: lastMessage ?? this.lastMessage,
        group: group ?? this.group,
        creator: creator ?? this.creator,
        theme: theme ?? this.theme,
      );

  @override
  List<Object?> get props => [
        id,
        members,
        name,
        profile,
        lastMessage,
        group,
        creator,
        theme,
      ];
}
