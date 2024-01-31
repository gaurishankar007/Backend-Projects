import '../../../../core/resources/data_state.dart';
import '../dataSources/auth_remote_source.dart';
import '../models/userData/user_data_model.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../domain/parameters/sign_up_param.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../../../injection/injector.dart';

import '../dataSources/auth_local_source.dart';
import '../models/user/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  final remote = AuthRemoteSourceImpl();
  final local = AuthLocalSourceImpl();

  @override
  FDState<UserDataModel> signIn(SignInPrm param) async {
    if (network.online) {
      final dState = await remote.signIn(param);
      if (dState is SuccessState) local.saveUserData(dState.data!);
      return dState;
    }
    return const NetworkFailureState();
  }

  @override
  FDState<UserDataModel> signUp(SignUpPrm param) async {
    if (network.online) {
      final dState = await remote.signUp(param);
      if (dState is SuccessState) local.saveUserData(dState.data!);
      return dState;
    }
    return const NetworkFailureState();
  }

  @override
  FDState<UserModel> updateProfile(String imagePath) async {
    if (network.online) return remote.updateProfile(imagePath);
    return const NetworkFailureState();
  }

  @override
  FDState<UserDataModel> getUserData() => local.getUserData();

  @override
  FDState<bool> saveUserData(UserDataModel userData) => local.saveUserData(userData);
}
