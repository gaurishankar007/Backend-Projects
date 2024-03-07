import 'package:isar/isar.dart';

import '../../models/user/user_model.dart';
import '../../models/userData/user_data_model.dart';

part 'user_data_collection.g.dart';

@Collection()
class UserDataCollection {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String userId;
  String userName;
  String userEmail;
  String userProfile;
  String accessToken;
  String refreshToken;

  UserDataCollection({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userProfile,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserDataCollection.fromModel(UserDataModel model) => UserDataCollection(
        userId: model.user.id,
        userName: model.user.name,
        userEmail: model.user.email,
        userProfile: model.user.profile,
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
      );

  UserDataModel toModel() => UserDataModel(
        user: UserModel(
          id: userId,
          name: userName,
          email: userEmail,
          profile: userProfile,
        ),
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
