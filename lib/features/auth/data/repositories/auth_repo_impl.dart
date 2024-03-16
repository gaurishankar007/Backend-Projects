import '../../../../core/resources/data_state.dart';
import '../../../../injection/injector.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/entities/user_setting.dart';
import '../../domain/forms/sign_in_form.dart';
import '../../domain/forms/sign_up_form.dart';
import '../../domain/repositories/auth_repo.dart';
import '../dataSources/auth_local_source.dart';
import '../dataSources/auth_remote_source.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteSource remote;
  final AuthLocalSource local;

  AuthRepositoryImplementation({required this.remote, required this.local});

  @override
  FutureData<UserData> signIn(SignInForm form) async {
    if (connectivity.isOnline) {
      final dataState = await remote.signIn(form);
      if (dataState is DataSuccessSate) local.saveUserData(dataState.data!);
      return dataState;
    }
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserData> signUp(SignUpForm form) async {
    if (connectivity.isOnline) {
      final dataState = await remote.signUp(form);
      if (dataState is DataSuccessSate) local.saveUserData(dataState.data!);
      return dataState;
    }
    return const NetworkFailureSate();
  }

  @override
  FutureData<User> updateProfile(String imagePath) async {
    if (connectivity.isOnline) return remote.updateProfile(imagePath);
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserData> getUserData() => local.getUserData();

  @override
  FutureBool saveUserData(UserData userData) => local.saveUserData(userData);

  @override
  FutureList<UserSetting> getUserSettings() => local.getUserSettings();

  @override
  FutureBool saveUserSetting(SettingNavigator navigator) => local.saveUserSetting(navigator);
}
