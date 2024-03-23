import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/services/user_service.dart';
import '../../../domain/forms/sign_in_form.dart';
import '../../../domain/useCases/sign_in_uc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  final SignInUseCase signInUseCase;
  final UserService userService;

  SignInCubit({required this.signInUseCase, required this.userService})
      : super(SignInState.initial()) {
    emit(state.copyWith(emailController: emailController, passwordController: passwordController));
  }

  Future<bool> sigIn() async {
    String? email = emailController.stream.valueOrNull;
    String? password = passwordController.stream.valueOrNull;
    if ([email, password].contains(null)) return false;

    emit(state.copyWith(error: ""));

    final form = SignInForm(email: email!, password: password!);
    final dataState = await signInUseCase.call(form);
    if (dataState is! DataSuccess) {
      emit(state.copyWith(error: dataState.error!.message));
      return false;
    }

    userService.userData = dataState.data!;
    return true;
  }
}
