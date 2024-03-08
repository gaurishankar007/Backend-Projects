import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../data/models/userData/user_data_model.dart';
import '../repositories/auth_repo.dart';

class SaveUserDataUseCase implements UseCase<bool, UserDataModel> {
  final AuthRepository authRepo;
  SaveUserDataUseCase(this.authRepo);

  @override
  FutureData<bool> call(UserDataModel parameter) async => await authRepo.saveUserData(parameter);
}
