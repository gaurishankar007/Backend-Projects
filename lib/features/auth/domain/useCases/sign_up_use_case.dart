import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../forms/sign_up_form.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserData, SignUpForm> {
  final AuthRepository _authRepository;
  SignUpUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  FutureData<UserData> call(SignUpForm parameter) async => await _authRepository.signUp(parameter);
}
