import '../domain/useCases/get_user_data_uc.dart';
import '../domain/useCases/save_user_data_uc.dart';

import '../data/repositories/auth_repo_impl.dart';
import '../domain/useCases/sign_in_uc.dart';
import '../domain/useCases/sign_up_uc.dart';
import '../domain/useCases/update_profile_uc.dart';

final authRepoImpl = AuthRepoImpl();

final signInUC = SignInUseCase(authRepoImpl);
final signUpUC = SignUpUseCase(authRepoImpl);
final getUserDataUC = GetUserDataUseCase(authRepoImpl);
final saveUserDataUC = SaveUserDataUseCase(authRepoImpl);
final updateProfileUC = UpdateProfileUseCase(authRepoImpl);
