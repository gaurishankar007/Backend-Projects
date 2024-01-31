import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/open_db.dart';
import '../isarCollections/userData/user_data_collection.dart';
import 'package:isar/isar.dart';

import '../models/userData/user_data_model.dart';

abstract class AuthLocalSource {
  FDState<bool> saveUserData(UserDataModel userData);
  FDState<UserDataModel> getUserData();
}

class AuthLocalSourceImpl implements AuthLocalSource {
  late final Future<Isar> _db;

  AuthLocalSourceImpl() {
    _db = openIsarDB();
  }

  @override
  FDState<bool> saveUserData(UserDataModel userData) async {
    return await exceptionHandler(() async {
      final userDataC = UserDataC.fromModel(userData);
      final isar = await _db;
      isar.writeTxnSync(() => isar.userDataCs.putSync(userDataC));
      return const SuccessState(data: true);
    });
  }

  @override
  FDState<UserDataModel> getUserData() async {
    return await exceptionHandler(() async {
      final isar = await _db;
      UserDataC? userDataC = await isar.userDataCs.where().findFirst();
      if (userDataC != null) {
        UserDataModel userData = userDataC.toModel();
        return SuccessState(data: userData);
      }

      return const FailureState<UserDataModel>();
    });
  }
}
