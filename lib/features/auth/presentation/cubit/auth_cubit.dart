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

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<DataState<UserDataModel>> signIn(SignInPrm param) async {
    final dState = await signInUC.call(param);
    if (dState is SuccessState) {
      appData.setUserData = dState.data!;
      replaceToDashboard();
    }

    return dState;
  }

  Future<DataState<UserDataModel>> signUp(SignUpPrm param) async {
    final dState = await signUpUC.call(param);
    if (dState is SuccessState) {
      appData.setUserData = dState.data!;
      pushName(updatePP);
    }

    return dState;
  }

  updateProfile(String imagePath) async {
    final dState = await updateProfileUC.call(imagePath);
    if (dState is SuccessState) {
      appData.setUserData = appData.userData.copyWith(user: dState.data!);
      saveUserDataUC.call(appData.userData);
      replaceToDashboard();
    }

    return dState;
  }

  signOut() async {
    final isar = await openIsarDB();
    isar.writeTxnSync(() => isar.clearSync());
    replaceToSignIn();
  }
}
