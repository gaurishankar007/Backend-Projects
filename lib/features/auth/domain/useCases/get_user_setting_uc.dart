import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case.dart';
import '../../data/isarCollections/userSetting/user_setting_collection.dart';
import '../repositories/auth_repo.dart';

class GetUserSettingUseCase implements UseCaseWithoutParameter<List<UserSettingCollection>> {
  final AuthRepository authRepo;
  GetUserSettingUseCase(this.authRepo);

  @override
  FutureData<List<UserSettingCollection>> call() async => await authRepo.getUserSettings();
}
