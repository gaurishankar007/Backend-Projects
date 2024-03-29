import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../forms/sign_in_form.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase implements UseCase<UserData, SignInForm> {
  final AuthRepository _authRepository;
  SignInUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  FutureData<UserData> call(SignInForm parameter) async => await _authRepository.signIn(parameter);
}
