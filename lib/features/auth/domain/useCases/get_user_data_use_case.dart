import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_data.dart';
import '../repositories/auth_repository.dart';

class GetUserDataUseCase implements UseCaseNoParameter<UserData> {
  final AuthRepository _authRepository;
  GetUserDataUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  FutureData<UserData> call() async => await _authRepository.getUserData();
}
