import 'package:isar/isar.dart';

import '../../../../setting/domain/entities/setting_navigator.dart';
import '../../../domain/entities/user_setting.dart';

part 'user_setting_collection.g.dart';

@Collection()
class UserSettingCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  int settingId;
  String title;
  String value;

  UserSettingCollection({
    required this.settingId,
    required this.title,
    required this.value,
  });

  factory UserSettingCollection.fromSettingNavigator(SettingNavigator navigator) =>
      UserSettingCollection(
        settingId: navigator.id,
        title: navigator.title,
        value: navigator.value,
      );

  UserSetting toUserSetting() => UserSetting(
        id: settingId,
        title: title,
        value: value,
      );
}
