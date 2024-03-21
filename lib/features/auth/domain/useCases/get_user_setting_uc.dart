import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../entities/user_setting.dart';
import '../repositories/auth_repo.dart';

class GetUserSettingUseCase implements UseCaseNoParameter<List<UserSetting>> {
  final AuthRepository authRepository;
  GetUserSettingUseCase({required this.authRepository});

  @override
  FutureData<List<UserSetting>> call() async => await authRepository.getUserSettings();
}
