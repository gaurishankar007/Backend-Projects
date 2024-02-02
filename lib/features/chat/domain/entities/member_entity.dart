import '../../../auth/domain/entities/user_entity.dart';

class MemberEntity {
  final String id;
  final UserEntity user;
  final String nickName;
  final String addedBy;
  final bool admin;
  final String seenMessage;

  const MemberEntity({
    required this.id,
    required this.user,
    required this.nickName,
    required this.addedBy,
    required this.admin,
    required this.seenMessage,
  });
}
