import 'package:api_data/src/middlewares/auth_middleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) => authMiddleware(handler);
