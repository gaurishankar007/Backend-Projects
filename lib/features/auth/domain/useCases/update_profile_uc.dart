import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../data/models/user/user_model.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repo.dart';

class UpdateProfileUseCase implements UseCase<UserEntity, String> {
  final AuthRepository authRepo;
  UpdateProfileUseCase(this.authRepo);

  @override
  FutureData<UserModel> call(String parameter) async => await authRepo.updateProfile(parameter);
}
