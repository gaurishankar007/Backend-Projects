import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/open_db.dart';
import '../isarCollections/userData/user_data_collection.dart';
import 'package:isar/isar.dart';

import '../models/userData/user_data_model.dart';

abstract class AuthLocalSource {
  FutureData<bool> saveUserData(UserDataModel userData);
  FutureData<UserDataModel> getUserData();
}

class AuthLocalSourceImplementation implements AuthLocalSource {
  late final Future<Isar> _database;

  AuthLocalSourceImplementation() {
    _database = openIsarDB();
  }

  @override
  FutureData<bool> saveUserData(UserDataModel userData) async {
    return await exceptionHandler(() async {
      final userDataC = UserDataCollection.fromModel(userData);
      final isar = await _database;
      isar.writeTxnSync(() => isar.userDataCollections.putSync(userDataC));
      return const DataSuccessSate(data: true);
    });
  }

  @override
  FutureData<UserDataModel> getUserData() async {
    return await exceptionHandler(() async {
      final isar = await _database;
      UserDataCollection? userDataC = await isar.userDataCollections.where().findFirst();
      if (userDataC != null) {
        UserDataModel userData = userDataC.toModel();
        return DataSuccessSate(data: userData);
      }

      return const DataFailureSate<UserDataModel>();
    });
  }
}
