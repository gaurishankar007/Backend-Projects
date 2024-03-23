import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/services/user_service.dart';
import '../../../domain/forms/sign_up_form.dart';
import '../../../domain/useCases/sign_up_uc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final nameController = BehaviorSubject<String>();
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final confirmPasswordController = BehaviorSubject<String>();

  final SignUpUseCase signUpUseCase;
  final UserService userService;

  SignUpCubit({required this.signUpUseCase, required this.userService})
      : super(SignUpState.initial()) {
    emit(state.copyWith(
      nameController: nameController,
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
    ));
  }

  Future<bool> sigUp() async {
    String? name = nameController.stream.valueOrNull;
    String? email = emailController.stream.valueOrNull;
    String? password = passwordController.stream.valueOrNull;
    String? confirmPassword = confirmPasswordController.stream.valueOrNull;
    if ([name, email, password, confirmPassword].contains(null)) return false;

    if (password != confirmPassword) {
      emit(state.copyWith(error: "Password did not matched with confirm password"));
      return false;
    }

    emit(state.copyWith(error: ""));

    SignUpForm form = SignUpForm(
      name: name!,
      email: email!,
      password: password!,
      confirmPassword: confirmPassword!,
    );
    final dataState = await signUpUseCase.call(form);
    if (dataState is! DataSuccess) {
      emit(state.copyWith(error: dataState.error!.message));
      return false;
    }

    userService.userData = dataState.data!;
    return true;
  }
}
