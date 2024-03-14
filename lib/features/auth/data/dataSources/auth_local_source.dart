import 'package:isar/isar.dart';

import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/local_database.dart';
import '../../../setting/data/models/settingNavigation/setting_navigation_model.dart';
import '../isarCollections/userData/user_data_collection.dart';
import '../isarCollections/userSetting/user_setting_collection.dart';
import '../models/userData/user_data_model.dart';

abstract class AuthLocalSource {
  FutureBool saveUserData(UserDataModel userData);
  FutureData<UserDataModel> getUserData();
  FutureList<UserSettingCollection> getUserSettings();
  FutureBool saveUserSetting(SettingNavigationModel model);
}

class AuthLocalSourceImplementation implements AuthLocalSource {
  late final Future<Isar> _database;

  AuthLocalSourceImplementation() {
    _database = openLocalDatabase();
  }

  @override
  FutureBool saveUserData(UserDataModel userData) async {
    return await exceptionHandler(() async {
      final userDataCollection = UserDataCollection.fromModel(userData);
      final isar = await _database;
      isar.writeTxnSync(() => isar.userDataCollections.putSync(userDataCollection));
      return const DataSuccessSate(data: true);
    });
  }

  @override
  FutureData<UserDataModel> getUserData() async {
    return await exceptionHandler(() async {
      final isar = await _database;
      final userDataCollection = await isar.userDataCollections.where().findFirst();
      if (userDataCollection != null) {
        UserDataModel userData = userDataCollection.toModel();
        return DataSuccessSate(data: userData);
      }

      return const DataFailureSate<UserDataModel>();
    });
  }

  @override
  FutureList<UserSettingCollection> getUserSettings() async {
    return await exceptionHandler(() async {
      final isar = await _database;
      final userSettings = await isar.userSettingCollections.where().findAll();
      return DataSuccessSate(data: userSettings);
    });
  }

  @override
  FutureBool saveUserSetting(SettingNavigationModel model) async {
    return await exceptionHandler(() async {
      final userSetting = UserSettingCollection.fromModel(model);
      final isar = await _database;
      isar.writeTxnSync(() => isar.userSettingCollections.putSync(userSetting));
      return const DataSuccessSate(data: true);
    });
  }
}
