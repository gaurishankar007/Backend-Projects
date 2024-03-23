import '../../../../core/resources/data_state.dart';
import '../../../../core/services/network_status.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/entities/user_setting.dart';
import '../../domain/forms/sign_in_form.dart';
import '../../domain/forms/sign_up_form.dart';
import '../../domain/repositories/auth_repo.dart';
import '../dataSources/auth_local_data_source.dart';
import '../dataSources/auth_remote_data_source.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final NetworkStatus networkStatus;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImplementation({
    required this.networkStatus,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  FutureData<UserData> signIn(SignInForm form) async {
    if (networkStatus.isOnline) {
      final dataState = await remoteDataSource.signIn(form);
      if (dataState is DataSuccess) localDataSource.saveUserData(dataState.data!);
      return dataState;
    }
    return const DataNetworkFailure();
  }

  @override
  FutureData<UserData> signUp(SignUpForm form) async {
    if (networkStatus.isOnline) {
      final dataState = await remoteDataSource.signUp(form);
      if (dataState is DataSuccess) localDataSource.saveUserData(dataState.data!);
      return dataState;
    }
    return const DataNetworkFailure();
  }

  @override
  FutureData<User> updateProfile(String imagePath) async {
    if (networkStatus.isOnline) return remoteDataSource.updateProfile(imagePath);
    return const DataNetworkFailure();
  }

  @override
  FutureData<UserData> getUserData() => localDataSource.getUserData();

  @override
  FutureBool saveUserData(UserData userData) => localDataSource.saveUserData(userData);

  @override
  FutureList<UserSetting> getUserSettings() => localDataSource.getUserSettings();

  @override
  FutureBool saveUserSetting(SettingNavigator navigator) =>
      localDataSource.saveUserSetting(navigator);
}
