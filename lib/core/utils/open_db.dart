import '../../features/auth/data/isarCollections/userData/user_data_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> openIsarDB() async {
  /// Open an isar instance if not opened
  if (Isar.instanceNames.isEmpty) {
    final directory = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [UserDataCollectionSchema],
      directory: directory.path,
      inspector: true,
    );
  }

  /// Get the opened isar instance
  return Future.value(Isar.getInstance());
}
