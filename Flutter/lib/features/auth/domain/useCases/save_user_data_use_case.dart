import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../repositories/auth_repository.dart';

class SaveUserDataUseCase implements UseCase<bool, UserData> {
  final AuthRepository _authRepository;
  SaveUserDataUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  FutureData<bool> call(UserData parameter) async => await _authRepository.saveUserData(parameter);
}
