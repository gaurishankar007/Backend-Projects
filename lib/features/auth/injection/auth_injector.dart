import '../../../injection/injector.dart';
import '../domain/useCases/get_user_data_uc.dart';
import '../domain/useCases/save_user_data_uc.dart';

import '../domain/useCases/sign_in_uc.dart';
import '../domain/useCases/sign_up_uc.dart';
import '../domain/useCases/update_profile_uc.dart';

get signInUseCase => SignInUseCase(authRepositoryImplementation);
get signUpUseCase => SignUpUseCase(authRepositoryImplementation);
get getUserDataUseCase => GetUserDataUseCase(authRepositoryImplementation);
get saveUserDataUseCase => SaveUserDataUseCase(authRepositoryImplementation);
get updateProfileUseCase => UpdateProfileUseCase(authRepositoryImplementation);
