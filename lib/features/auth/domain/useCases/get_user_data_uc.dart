import '../../../../core/resources/data_state.dart';

import '../../../../core/useCase/use_case.dart';
import '../../data/models/userData/user_data_model.dart';
import '../repositories/auth_repo.dart';

class GetUserDataUseCase implements UC<UserDataModel?> {
  final AuthRepo authRepo;
  GetUserDataUseCase(this.authRepo);

  @override
  FDState<UserDataModel?> call() async => await authRepo.getUserData();
}
