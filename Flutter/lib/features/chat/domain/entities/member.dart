import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user.dart';

class Member extends Equatable {
  final String id;
  final User user;
  final String nickName;
  final String addedBy;
  final bool admin;
  final String seenMessage;

  const Member({
    required this.id,
    required this.user,
    required this.nickName,
    required this.addedBy,
    required this.admin,
    required this.seenMessage,
  });

  Member copyWith({
    String? nickName,
    String? addedBy,
    String? seenMessage,
    User? user,
    bool? admin,
    bool? superAdmin,
    String? id,
  }) =>
      Member(
        id: id ?? this.id,
        user: user ?? this.user,
        nickName: nickName ?? this.nickName,
        addedBy: addedBy ?? this.addedBy,
        admin: admin ?? this.admin,
        seenMessage: seenMessage ?? this.seenMessage,
      );

  @override
  List<Object?> get props => [
        id,
        user,
        nickName,
        addedBy,
        admin,
        seenMessage,
      ];
}
