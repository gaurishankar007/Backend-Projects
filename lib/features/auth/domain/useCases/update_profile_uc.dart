import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class UpdateProfileUseCase implements UseCase<User, String> {
  final AuthRepository authRepository;
  UpdateProfileUseCase({required this.authRepository});

  @override
  FutureData<User> call(String parameter) async => await authRepository.updateProfile(parameter);
}
