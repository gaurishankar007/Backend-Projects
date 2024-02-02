import '../../data/models/userData/user_data_model.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case_param.dart';
import '../entities/user_data_entity.dart';
import '../parameters/sign_up_param.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase implements UCP<UserDataEntity, SignUpPrm> {
  final AuthRepo authRepo;
  SignUpUseCase(this.authRepo);

  @override
  FDState<UserDataModel> call(SignUpPrm param) async => await authRepo.signUp(param);
}
