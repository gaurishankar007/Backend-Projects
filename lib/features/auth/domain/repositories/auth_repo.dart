import '../../../../core/resources/data_state.dart';
import '../../data/models/user/user_model.dart';
import '../../data/models/userData/user_data_model.dart';
import '../parameters/sign_in_param.dart';
import '../parameters/sign_up_param.dart';

abstract class AuthRepository {
  FutureData<UserDataModel> signIn(SignInParameter parameter);
  FutureData<UserDataModel> signUp(SignUpParameter parameter);
  FutureData<UserDataModel> getUserData();
  FutureData<bool> saveUserData(UserDataModel userData);
  FutureData<UserModel> updateProfile(String imagePath);
}
