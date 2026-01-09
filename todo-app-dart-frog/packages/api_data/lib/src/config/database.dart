import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database(this.db);
  final Db db;

  DbCollection get users => db.collection('users');
  DbCollection get todos => db.collection('todos');

  static Future<Database> connect(String connectionString) async {
    final db = await Db.create(connectionString);
    await db.open();

    // Create indexes
    await db.collection('users').createIndex(
      keys: {'email': 1},
      unique: true,
    );
    await db.collection('todos').createIndex(keys: {'userId': 1});

    return Database(db);
  }

  Future<void> close() async {
    await db.close();
  }
}
