import '../../domain/useCases/sign_in_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCases/sign_up_uc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(AuthState.initial());
}
