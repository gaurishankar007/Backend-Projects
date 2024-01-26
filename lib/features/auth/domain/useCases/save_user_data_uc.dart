import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case_param.dart';

import '../../data/models/userData/user_data_model.dart';
import '../repositories/auth_repo.dart';

class SaveUserDataUseCase implements UCP<bool, UserDataModel> {
  final AuthRepo authRepo;
  SaveUserDataUseCase(this.authRepo);

  @override
  FDState<bool> call(UserDataModel param) async => await authRepo.saveUserData(param);
}
