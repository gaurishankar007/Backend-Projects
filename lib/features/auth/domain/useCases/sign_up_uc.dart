import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../forms/sign_up_form.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase implements UseCase<UserData, SignUpForm> {
  final AuthRepository authRepo;
  SignUpUseCase(this.authRepo);

  @override
  FutureData<UserData> call(SignUpForm parameter) async => await authRepo.signUp(parameter);
}
