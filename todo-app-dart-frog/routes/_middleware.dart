import 'package:api_data/src/config/database.dart';
import 'package:api_data/src/services/jwt_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

Database? _database;

Handler middleware(Handler handler) {
  return (context) async {
    // Load environment variables
    final env = DotEnv()..load();

    // Initialize database connection
    if (_database == null) {
      final mongoUri =
          env['MONGODB_URI'] ?? 'mongodb://localhost:27017/dart_frog_todo';
      _database = await Database.connect(mongoUri);
    }

    // Initialize JWT service
    final jwtSecret = env['JWT_SECRET'] ?? 'change-this-secret';
    final accessExpiry = parseDuration(env['JWT_ACCESS_EXPIRY'] ?? '15m');
    final refreshExpiry = parseDuration(env['JWT_REFRESH_EXPIRY'] ?? '7d');

    final jwtService = JwtService(
      secret: jwtSecret,
      accessExpiry: accessExpiry,
      refreshExpiry: refreshExpiry,
    );

    // Provide services to context
    final updatedContext = context
        .provide<Database>(() => _database!)
        .provide<JwtService>(() => jwtService);

    return handler(updatedContext);
  };
}
