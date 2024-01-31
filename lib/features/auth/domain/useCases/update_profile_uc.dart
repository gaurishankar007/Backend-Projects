import '../../../../core/resources/data_state.dart';
import '../../../../core/useCase/use_case_param.dart';
import '../../data/models/user/user_model.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repo.dart';

class UpdateProfileUseCase implements UCP<User, String> {
  final AuthRepo authRepo;
  UpdateProfileUseCase(this.authRepo);

  @override
  FDState<UserModel> call(String param) async => await authRepo.updateProfile(param);
}
