import '../../features/auth/data/isarCollections/userData/user_data_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> openIsarDB() async {
  if (Isar.instanceNames.isEmpty) {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [UserDataCSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  return Future.value(Isar.getInstance());
}
