import 'core/resources/data_state.dart';
import 'features/auth/injection/auth_injector.dart';

import 'features/auth/data/models/userData/user_data_model.dart';
import 'injection/injector.dart';

class AppData {
  AppData._();
  static final _singleton = AppData._();
  factory AppData() => _singleton;

  UserDataModel? _userData;

  Future<void> init() async {
    initDependencies();
    await network.listen();
    await _checkLogin();
  }

  _checkLogin() async {
    final dState = await getUserDataUC.call();
    if (dState is SuccessState) _userData = dState.data!;
  }

  bool get isLoggedIn => _userData != null;
  set setUserData(UserDataModel userData) => _userData = userData;
  UserDataModel get userData => _userData!;
}
