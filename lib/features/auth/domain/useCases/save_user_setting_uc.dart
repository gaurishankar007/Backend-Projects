import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../../dashboard/data/models/settingNavigation/setting_navigation_model.dart';
import '../repositories/auth_repo.dart';

class SaveUserSettingUseCase implements UseCase<bool, SettingNavigationModel> {
  final AuthRepository authRepo;
  SaveUserSettingUseCase(this.authRepo);

  @override
  FutureData<bool> call(SettingNavigationModel parameter) async =>
      await authRepo.saveUserSetting(parameter);
}
