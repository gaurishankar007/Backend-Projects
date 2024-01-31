import '../../../injection/injector.dart';
import '../domain/useCases/get_user_data_uc.dart';
import '../domain/useCases/save_user_data_uc.dart';

import '../domain/useCases/sign_in_uc.dart';
import '../domain/useCases/sign_up_uc.dart';
import '../domain/useCases/update_profile_uc.dart';

SignInUseCase get signInUC => SignInUseCase(authRepoImpl);
SignUpUseCase get signUpUC => SignUpUseCase(authRepoImpl);
GetUserDataUseCase get getUserDataUC => GetUserDataUseCase(authRepoImpl);
SaveUserDataUseCase get saveUserDataUC => SaveUserDataUseCase(authRepoImpl);
UpdateProfileUseCase get updateProfileUC => UpdateProfileUseCase(authRepoImpl);
