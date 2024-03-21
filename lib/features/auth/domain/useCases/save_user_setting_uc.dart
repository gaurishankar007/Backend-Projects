import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../repositories/auth_repo.dart';

class SaveUserSettingUseCase implements UseCase<bool, SettingNavigator> {
  final AuthRepository authRepository;
  SaveUserSettingUseCase({required this.authRepository});

  @override
  FutureData<bool> call(SettingNavigator parameter) async =>
      await authRepository.saveUserSetting(parameter);
}
