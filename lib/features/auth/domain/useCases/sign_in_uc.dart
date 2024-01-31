import '../../data/models/userData/user_data_model.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case_param.dart';
import '../entities/user_data_entity.dart';
import '../parameters/sign_in_param.dart';
import '../repositories/auth_repo.dart';

class SignInUseCase implements UCP<UserData, SignInPrm> {
  final AuthRepo authRepo;
  SignInUseCase(this.authRepo);

  @override
  FDState<UserDataModel> call(SignInPrm param) async => await authRepo.signIn(param);
}
