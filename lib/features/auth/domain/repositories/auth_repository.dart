import '../../../../core/resources/data_state.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../entities/user.dart';
import '../entities/user_data.dart';
import '../entities/user_setting.dart';
import '../forms/sign_in_form.dart';
import '../forms/sign_up_form.dart';

abstract class AuthRepository {
  FutureData<UserData> signIn(SignInForm parameter);
  FutureData<UserData> signUp(SignUpForm parameter);
  FutureData<User> updateProfile(String imagePath);
  FutureData<UserData> getUserData();
  FutureBool saveUserData(UserData userData);
  FutureList<UserSetting> getUserSettings();
  FutureBool saveUserSetting(SettingNavigator navigator);
}
