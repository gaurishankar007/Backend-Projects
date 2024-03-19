import '../../../../core/services/local_database.dart';

import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/entities/user_setting.dart';
import '../isarCollections/userData/user_data_collection.dart';
import '../isarCollections/userSetting/user_setting_collection.dart';

abstract class AuthLocalDataSource {
  FutureBool saveUserData(UserData userData);
  FutureData<UserData> getUserData();
  FutureList<UserSetting> getUserSettings();
  FutureBool saveUserSetting(SettingNavigator navigator);
}

class AuthLocalDataSourceImplementation implements AuthLocalDataSource {
  final LocalDatabase localDatabase;

  AuthLocalDataSourceImplementation({required this.localDatabase});

  @override
  FutureBool saveUserData(UserData userData) async {
    return await exceptionHandler(() async {
      final userDataCollection = UserDataCollection.fromUserData(userData);
      await localDatabase.save(userDataCollection);
      return const DataSuccess(data: true);
    });
  }

  @override
  FutureData<UserData> getUserData() async {
    return await exceptionHandler(() async {
      final userDataCollections = await localDatabase.getAll<UserDataCollection>();
      if (userDataCollections.isNotEmpty) {
        UserData userData = userDataCollections.first.toUserData();
        return DataSuccess(data: userData);
      }

      return const DataFailure<UserData>();
    });
  }

  @override
  FutureList<UserSetting> getUserSettings() async {
    return await exceptionHandler(() async {
      final userSettingCollections = await localDatabase.getAll<UserSettingCollection>();
      final userSettings = userSettingCollections.map((e) => e.toUserSetting()).toList();
      return DataSuccess(data: userSettings);
    });
  }

  @override
  FutureBool saveUserSetting(SettingNavigator navigator) async {
    return await exceptionHandler(() async {
      final userSetting = UserSettingCollection.fromSettingNavigator(navigator);
      await localDatabase.save(userSetting);
      return const DataSuccess(data: true);
    });
  }
}
