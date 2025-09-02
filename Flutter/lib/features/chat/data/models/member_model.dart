import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.user,
    required super.nickName,
    required super.addedBy,
    required super.admin,
    required super.seenMessage,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json['_id'] as String,
        user: UserModel.fromJson(json['user']),
        nickName: json['nickName'] as String,
        addedBy: json['addedBy'] as String,
        admin: json['admin'] as bool,
        seenMessage: json['seenMessage'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'user': user,
        'nickName': nickName,
        'addedBy': addedBy,
        'admin': admin,
        'seenMessage': seenMessage,
      };
}
