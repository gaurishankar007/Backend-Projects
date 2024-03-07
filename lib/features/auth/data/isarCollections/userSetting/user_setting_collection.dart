import 'package:isar/isar.dart';

import '../../../../dashboard/data/models/settingNavigation/setting_navigation_model.dart';

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

  factory UserSettingCollection.fromModel(SettingNavigationModel model) => UserSettingCollection(
        settingId: model.id,
        title: model.title,
        value: model.value,
      );
}
