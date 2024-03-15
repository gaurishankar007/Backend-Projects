import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../data/models/userData/user_data_model.dart';
import '../entities/user_data.dart';
import '../parameters/sign_up_param.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase implements UseCase<UserData, SignUpParameter> {
  final AuthRepository authRepo;
  SignUpUseCase(this.authRepo);

  @override
  FutureData<UserDataModel> call(SignUpParameter parameter) async =>
      await authRepo.signUp(parameter);
}
