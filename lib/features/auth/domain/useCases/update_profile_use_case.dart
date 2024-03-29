import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase implements UseCase<User, String> {
  final AuthRepository _authRepository;
  UpdateProfileUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  FutureData<User> call(String parameter) async => await _authRepository.updateProfile(parameter);
}
