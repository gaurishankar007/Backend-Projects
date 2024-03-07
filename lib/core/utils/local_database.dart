import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/data/isarCollections/userData/user_data_collection.dart';
import '../../features/auth/data/isarCollections/userSetting/user_setting_collection.dart';

Future<Isar> openLocalDatabase() async {
  /// Open an isar instance if not opened
  if (Isar.instanceNames.isEmpty) {
    /// Get the root directory of the application
    final directory = await getApplicationDocumentsDirectory();

    return await Isar.open(
      [
        UserDataCollectionSchema,
        UserSettingCollectionSchema,
      ],
      directory: directory.path,
      inspector: true,
    );
  }

  /// Get the opened isar instance
  return Future.value(Isar.getInstance());
}
