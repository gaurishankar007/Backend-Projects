import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../repositories/auth_repo.dart';

class GetUserDataUseCase implements UseCaseWithoutParameter<UserData> {
  final AuthRepository authRepo;
  GetUserDataUseCase(this.authRepo);

  @override
  FutureData<UserData> call() async => await authRepo.getUserData();
}
