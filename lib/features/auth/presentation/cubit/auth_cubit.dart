import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/navigator.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/services/network_service.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../domain/forms/sign_in_form.dart';
import '../../domain/forms/sign_up_form.dart';
import '../dependencies/auth_cubit_dependency.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthCubitDependency dependency;

  AuthCubit({required this.dependency}) : super(AuthState.initial());

  removeSignUpError() => emit(state.copyWith(signUpError: ""));
  updateProfileError(String error) => emit(state.copyWith(updateProfileError: error));
  removeUpdateProfileError() => emit(state.copyWith(updateProfileError: ""));

  sigIn({required String email, required String password}) async {
    emit(state.copyWith(signInError: ""));

    final parameter = SignInForm(email: email, password: password);
    final dataState = await dependency.signInUseCase.call(parameter);

    if (dataState is DataSuccess) {
      dependency.userService.userData = dataState.data!;
      return replaceToDashboard();
    }

    emit(state.copyWith(signInError: dataState.error!.message));
  }

  sigUp({required SignUpForm form}) async {
    emit(state.copyWith(signUpError: ""));

    if (form.password != form.confirmPassword) {
      return emit(state.copyWith(signUpError: "Password did not matched with confirm password"));
    }

    final dataState = await dependency.signUpUseCase.call(form);
    if (dataState is DataSuccess) {
      dependency.userService.userData = dataState.data!;
      pushName(kUpdateProfilePath);
      removeLast();
      return;
    }

    emit(state.copyWith(signUpError: dataState.error!.message));
  }

  updateProfile(DioFormData formData) async {
    emit(state.copyWith(updateProfileError: ""));

    final dataState = await dependency.updateProfileUseCase.call(formData);

    if (dataState is DataSuccess) {
      dependency.userService.userData =
          dependency.userService.userData.copyWith(user: dataState.data!);
      dependency.saveUserDataUseCase.call(dependency.userService.userData);
      return replaceToDashboard();
    }

    emit(state.copyWith(updateProfileError: dataState.error!.message));
  }

  changeSetting(SettingNavigator navigator) {
    dependency.userService.changeSetting(navigator);
    dependency.saveUserSettingUseCase.call(navigator);
  }
}
