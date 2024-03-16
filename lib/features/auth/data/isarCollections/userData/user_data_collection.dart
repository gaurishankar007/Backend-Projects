import 'package:isar/isar.dart';

import '../../../domain/entities/user_data.dart';
import '../../models/user_model.dart';

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

  factory UserDataCollection.fromUserData(UserData userData) => UserDataCollection(
        userId: userData.user.id,
        userName: userData.user.name,
        userEmail: userData.user.email,
        userProfile: userData.user.profile,
        accessToken: userData.accessToken,
        refreshToken: userData.refreshToken,
      );

  UserData toUserData() => UserData(
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
