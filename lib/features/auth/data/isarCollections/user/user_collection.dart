import 'package:isar/isar.dart';

import '../../models/user/user_model.dart';

part 'user_collection.g.dart';

@Collection()
@Name("UserC")
class UserC {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String id;
  String name;
  String email;
  String profilePic;

  UserC({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  factory UserC.fromModel(UserModel model) => UserC(
        id: model.id,
        name: model.name,
        email: model.email,
        profilePic: model.profilePic,
      );

  UserModel toModel() => UserModel(id: id, name: name, email: email, profilePic: profilePic);
}
