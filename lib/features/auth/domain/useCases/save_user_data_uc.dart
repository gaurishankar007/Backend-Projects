import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../repositories/auth_repo.dart';

class SaveUserDataUseCase implements UseCase<bool, UserData> {
  final AuthRepository authRepo;
  SaveUserDataUseCase(this.authRepo);

  @override
  FutureData<bool> call(UserData parameter) async => await authRepo.saveUserData(parameter);
}
