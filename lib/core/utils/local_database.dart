import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/data/isarCollections/userData/user_data_collection.dart';
import '../../features/auth/data/isarCollections/userSetting/user_setting_collection.dart';

abstract class LocalDatabase {
  Future<bool> save<T>(T item);
  Future<List<T>> getAll<T>();
  Future<bool> clearAll();
}

/// A class for opening local database and executing operations
class LocalDatabaseImplementation implements LocalDatabase {
  LocalDatabaseImplementation._();
  static final _singleton = LocalDatabaseImplementation._();
  factory LocalDatabaseImplementation() => _singleton;

  late final Isar isar;

  Future openLocalDatabase() async {
    /// Open an isar instance if not opened
    if (Isar.instanceNames.isEmpty) {
      /// Get the root directory of the application
      final directory = await getApplicationDocumentsDirectory();

      isar = await Isar.open(
        [
          UserDataCollectionSchema,
          UserSettingCollectionSchema,
        ],
        directory: directory.path,
        inspector: true,
      );
    }
  }

  @override
  Future<bool> save<T>(T item) async {
    await isar.writeTxn(() => isar.collection<T>().put(item));
    return true;
  }

  @override
  Future<List<T>> getAll<T>() async => await isar.collection<T>().where().findAll();

  @override
  Future<bool> clearAll() async {
    await isar.writeTxn(() => isar.clear());
    return true;
  }
}
