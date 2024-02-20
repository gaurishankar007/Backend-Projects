import '../../../../core/constants/routes_data.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/open_db.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../injection/auth_injector.dart';
import '../../../../injection/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/userData/user_data_model.dart';
import '../../domain/parameters/sign_up_param.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState?> {
  AuthCubit() : super(null);

  FutureData<UserDataModel> signIn(SignInParameter parameter) async {
    final dataState = await signInUseCase.call(parameter);
    if (dataState is DataSuccessSate) {
      appData.setUserData = dataState.data!;
      replaceToDashboard();
    }

    return dataState;
  }

  FutureData<UserDataModel> signUp(SignUpParameter parameter) async {
    final dataState = await signUpUC.call(parameter);
    if (dataState is DataSuccessSate) {
      appData.setUserData = dataState.data!;
      pushName(kUpdateProfilePath);
    }

    return dataState;
  }

  updateProfile(String imagePath) async {
    final dataState = await updateProfileUseCase.call(imagePath);
    if (dataState is DataSuccessSate) {
      appData.setUserData = appData.userData.copyWith(user: dataState.data!);
      saveUserDataUseCase.call(appData.userData);
      replaceToDashboard();
    }

    return dataState;
  }

  signOut() async {
    final isar = await openIsarDB();
    isar.writeTxnSync(() => isar.clearSync());
    replaceToSignIn();
  }
}
