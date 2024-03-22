import '../../../../core/services/user_service.dart';
import '../../domain/useCases/save_user_data_uc.dart';
import '../../domain/useCases/save_user_setting_uc.dart';
import '../../domain/useCases/sign_in_uc.dart';
import '../../domain/useCases/sign_up_uc.dart';
import '../../domain/useCases/update_profile_uc.dart';

class AuthCubitDependency {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final SaveUserDataUseCase saveUserDataUseCase;
  final SaveUserSettingUseCase saveUserSettingUseCase;
  final UserService userService;

  const AuthCubitDependency({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.updateProfileUseCase,
    required this.saveUserDataUseCase,
    required this.saveUserSettingUseCase,
    required this.userService,
  });
}
