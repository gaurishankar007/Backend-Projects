import '../../../../core/resources/data_state.dart';
import '../../../../injection/injector.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../domain/parameters/sign_up_param.dart';
import '../../domain/repositories/auth_repo.dart';
import '../dataSources/auth_local_source.dart';
import '../dataSources/auth_remote_source.dart';
import '../isarCollections/userSetting/user_setting_collection.dart';
import '../models/user/user_model.dart';
import '../models/userData/user_data_model.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteSource remote;
  final AuthLocalSource local;

  AuthRepositoryImplementation({required this.remote, required this.local});

  @override
  FutureData<UserDataModel> signIn(SignInParameter parameter) async {
    if (connectivity.isOnline) {
      final dataState = await remote.signIn(parameter);
      if (dataState is DataSuccessSate) local.saveUserData(dataState.data!);
      return dataState;
    }
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserDataModel> signUp(SignUpParameter parameter) async {
    if (connectivity.isOnline) {
      final dataState = await remote.signUp(parameter);
      if (dataState is DataSuccessSate) local.saveUserData(dataState.data!);
      return dataState;
    }
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserModel> updateProfile(String imagePath) async {
    if (connectivity.isOnline) return remote.updateProfile(imagePath);
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserDataModel> getUserData() => local.getUserData();

  @override
  FutureBool saveUserData(UserDataModel userData) => local.saveUserData(userData);

  @override
  FutureList<UserSettingCollection> getUserSettings() => local.getUserSettings();

  @override
  FutureBool saveUserSetting(SettingNavigator model) => local.saveUserSetting(model);
}
