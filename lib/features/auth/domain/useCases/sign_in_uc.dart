import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../data/models/userData/user_data_model.dart';
import '../entities/user_data.dart';
import '../parameters/sign_in_param.dart';
import '../repositories/auth_repo.dart';

class SignInUseCase implements UseCase<UserData, SignInParameter> {
  final AuthRepository authRepo;
  SignInUseCase(this.authRepo);

  @override
  FutureData<UserDataModel> call(SignInParameter parameter) async =>
      await authRepo.signIn(parameter);
}
