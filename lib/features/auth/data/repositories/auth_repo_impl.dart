import '../../../../core/resources/data_state.dart';
import '../dataSources/auth_remote_source.dart';
import '../models/userData/user_data_model.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../domain/parameters/sign_up_param.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../../../injection/injector.dart';

import '../dataSources/auth_local_source.dart';
import '../models/user/user_model.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteSourceImplementation remote;
  final AuthLocalSourceImplementation local;

  AuthRepositoryImplementation({required this.remote, required this.local});

  @override
  FutureData<UserDataModel> signIn(SignInParameter parameter) async {
    if (network.isOnline) {
      final dataState = await remote.signIn(parameter);
      if (dataState is DataSuccessSate) local.saveUserData(dataState.data!);
      return dataState;
    }
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserDataModel> signUp(SignUpParameter parameter) async {
    if (network.isOnline) {
      final dataState = await remote.signUp(parameter);
      if (dataState is DataSuccessSate) local.saveUserData(dataState.data!);
      return dataState;
    }
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserModel> updateProfile(String imagePath) async {
    if (network.isOnline) return remote.updateProfile(imagePath);
    return const NetworkFailureSate();
  }

  @override
  FutureData<UserDataModel> getUserData() => local.getUserData();

  @override
  FutureData<bool> saveUserData(UserDataModel userData) => local.saveUserData(userData);
}
