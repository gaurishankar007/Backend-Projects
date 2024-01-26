import 'package:isar/isar.dart';

import '../../../domain/entities/user_data_entity.dart';
import '../../models/user/user_model.dart';
import '../../models/userData/user_data_model.dart';

part 'user_data_collection.g.dart';

@Collection()
@Name("UserDataC")
class UserDataC {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String userId;
  String userName;
  String userEmail;
  String userProfilePic;
  String accessToken;
  String refreshToken;
  @enumerated
  ThemeStyle themeStyle;

  UserDataC({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userProfilePic,
    required this.accessToken,
    required this.refreshToken,
    required this.themeStyle,
  });

  factory UserDataC.fromModel(UserDataModel model) => UserDataC(
        userId: model.user.id,
        userName: model.user.name,
        userEmail: model.user.email,
        userProfilePic: model.user.profilePic,
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
        themeStyle: model.themeStyle,
      );

  UserDataModel toModel() => UserDataModel(
        user: UserModel(
          id: userId,
          name: userName,
          email: userEmail,
          profilePic: userProfilePic,
        ),
        accessToken: accessToken,
        refreshToken: refreshToken,
        themeStyle: themeStyle,
      );
}
