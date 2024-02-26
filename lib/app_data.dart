import 'core/resources/data_state.dart';
import 'features/auth/injection/auth_injector.dart';

import 'features/auth/data/models/userData/user_data_model.dart';
import 'injection/injector.dart';

class AppData {
  AppData._();
  static final _singleton = AppData._();
  factory AppData() => _singleton;

  UserDataModel? _userData;

  Future<void> initialize() async {
    initializeDependencies();

    await network.checkConnection();
    await _authenticate();
  }

  _authenticate() async {
    final dataState = await getUserDataUseCase.call();
    if (dataState is DataSuccessSate) _userData = dataState.data!;
  }

  bool get isLoggedIn => _userData != null;
  set setUserData(UserDataModel userData) => _userData = userData;
  UserDataModel get userData => _userData!;
}
