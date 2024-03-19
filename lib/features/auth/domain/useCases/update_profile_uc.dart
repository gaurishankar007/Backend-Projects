import '../../../../core/resources/data_state.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class UpdateProfileUseCase implements UseCase<User, DioFormData> {
  final AuthRepository authRepo;
  UpdateProfileUseCase(this.authRepo);

  @override
  FutureData<User> call(DioFormData parameter) async => await authRepo.updateProfile(parameter);
}
