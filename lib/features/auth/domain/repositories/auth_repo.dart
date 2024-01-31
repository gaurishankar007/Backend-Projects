import '../../../../core/resources/data_state.dart';
import '../../data/models/user/user_model.dart';
import '../../data/models/userData/user_data_model.dart';
import '../parameters/sign_in_param.dart';
import '../parameters/sign_up_param.dart';

abstract class AuthRepo {
  FDState<UserDataModel> signIn(SignInPrm param);
  FDState<UserDataModel> signUp(SignUpPrm param);
  FDState<UserDataModel> getUserData();
  FDState<bool> saveUserData(UserDataModel userData);
  FDState<UserModel> updateProfile(String imagePath);
}
