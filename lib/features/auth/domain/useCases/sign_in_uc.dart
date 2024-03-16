import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../forms/sign_in_form.dart';
import '../repositories/auth_repo.dart';

class SignInUseCase implements UseCase<UserData, SignInForm> {
  final AuthRepository authRepo;
  SignInUseCase(this.authRepo);

  @override
  FutureData<UserData> call(SignInForm parameter) async => await authRepo.signIn(parameter);
}
