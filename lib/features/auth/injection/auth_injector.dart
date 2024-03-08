import '../../../injection/injector.dart';
import '../domain/useCases/get_user_data_uc.dart';
import '../domain/useCases/get_user_setting_uc.dart';
import '../domain/useCases/save_user_data_uc.dart';
import '../domain/useCases/save_user_setting_uc.dart';
import '../domain/useCases/sign_in_uc.dart';
import '../domain/useCases/sign_up_uc.dart';
import '../domain/useCases/update_profile_uc.dart';

SignInUseCase get signInUseCase => SignInUseCase(authRepositoryImplementation);
SignUpUseCase get signUpUseCase => SignUpUseCase(authRepositoryImplementation);
UpdateProfileUseCase get updateProfileUseCase => UpdateProfileUseCase(authRepositoryImplementation);
GetUserDataUseCase get getUserDataUseCase => GetUserDataUseCase(authRepositoryImplementation);
SaveUserDataUseCase get saveUserDataUseCase => SaveUserDataUseCase(authRepositoryImplementation);
GetUserSettingUseCase get getUserSettingUseCase =>
    GetUserSettingUseCase(authRepositoryImplementation);
SaveUserSettingUseCase get saveUserSettingUseCase =>
    SaveUserSettingUseCase(authRepositoryImplementation);
