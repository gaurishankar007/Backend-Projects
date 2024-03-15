import '../../../../core/resources/data_state.dart';
import '../../../setting/domain/entities/setting_navigator.dart';
import '../../data/isarCollections/userSetting/user_setting_collection.dart';
import '../../data/models/user/user_model.dart';
import '../../data/models/userData/user_data_model.dart';
import '../parameters/sign_in_param.dart';
import '../parameters/sign_up_param.dart';

abstract class AuthRepository {
  FutureData<UserDataModel> signIn(SignInParameter parameter);
  FutureData<UserDataModel> signUp(SignUpParameter parameter);
  FutureData<UserModel> updateProfile(String imagePath);
  FutureData<UserDataModel> getUserData();
  FutureBool saveUserData(UserDataModel userData);
  FutureList<UserSettingCollection> getUserSettings();
  FutureBool saveUserSetting(SettingNavigator model);
}
