import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_setting.dart';
import '../repositories/auth_repository.dart';

class GetUserSettingUseCase implements UseCaseNoParameter<List<UserSetting>> {
  final AuthRepository _authRepository;
  GetUserSettingUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  FutureData<List<UserSetting>> call() async => await _authRepository.getUserSettings();
}
