import 'package:isar/isar.dart';

import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/local_database.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/entities/user_setting.dart';
import '../isarCollections/userData/user_data_collection.dart';
import '../isarCollections/userSetting/user_setting_collection.dart';

abstract class AuthLocalSource {
  FutureBool saveUserData(UserData userData);
  FutureData<UserData> getUserData();
  FutureList<UserSetting> getUserSettings();
  FutureBool saveUserSetting(SettingNavigator navigator);
}

class AuthLocalSourceImplementation implements AuthLocalSource {
  late final Future<Isar> _database;

  AuthLocalSourceImplementation() {
    _database = openLocalDatabase();
  }

  @override
  FutureBool saveUserData(UserData userData) async {
    return await exceptionHandler(() async {
      final userDataCollection = UserDataCollection.fromUserData(userData);
      final isar = await _database;
      isar.writeTxnSync(() => isar.userDataCollections.putSync(userDataCollection));
      return const DataSuccessSate(data: true);
    });
  }

  @override
  FutureData<UserData> getUserData() async {
    return await exceptionHandler(() async {
      final isar = await _database;
      final userDataCollection = await isar.userDataCollections.where().findFirst();
      if (userDataCollection != null) {
        UserData userData = userDataCollection.toUserData();
        return DataSuccessSate(data: userData);
      }

      return const DataFailureSate<UserData>();
    });
  }

  @override
  FutureList<UserSetting> getUserSettings() async {
    return await exceptionHandler(() async {
      final isar = await _database;
      final userSettingCollections = await isar.userSettingCollections.where().findAll();
      final userSettings = userSettingCollections.map((e) => e.toUserSetting());
      return DataSuccessSate(data: userSettings);
    });
  }

  @override
  FutureBool saveUserSetting(SettingNavigator navigator) async {
    return await exceptionHandler(() async {
      final userSetting = UserSettingCollection.fromSettingNavigator(navigator);
      final isar = await _database;
      isar.writeTxnSync(() => isar.userSettingCollections.putSync(userSetting));
      return const DataSuccessSate(data: true);
    });
  }
}
