import '../../../../core/resources/data_state.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class UpdateProfileUseCase implements UseCase<User, DioFormData> {
  final AuthRepository authRepository;
  UpdateProfileUseCase({required this.authRepository});

  @override
  FutureData<User> call(DioFormData parameter) async =>
      await authRepository.updateProfile(parameter);
}
