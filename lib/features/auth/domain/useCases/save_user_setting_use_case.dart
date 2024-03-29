import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../repositories/auth_repository.dart';

class SaveUserSettingUseCase implements UseCase<bool, SettingNavigator> {
  final AuthRepository _authRepository;
  SaveUserSettingUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  FutureData<bool> call(SettingNavigator parameter) async =>
      await _authRepository.saveUserSetting(parameter);
}
