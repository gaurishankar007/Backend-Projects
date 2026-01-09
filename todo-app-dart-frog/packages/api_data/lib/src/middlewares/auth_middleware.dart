import 'package:api_data/src/services/jwt_service.dart';
import 'package:dart_frog/dart_frog.dart';

Handler authMiddleware(Handler handler) {
  return (context) async {
    // Extract Authorization header
    final authHeader = context.request.headers['Authorization'];

    if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Authorization token required'},
      );
    }

    // Extract token
    final token = authHeader.substring(7);
    final jwtService = context.read<JwtService>();

    // Verify token
    final payload = jwtService.verifyToken(token);

    if (payload == null) {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid or expired token'},
      );
    }

    // Check token type
    if (payload['type'] != 'access') {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid token type. Access token required'},
      );
    }

    final userId = payload['userId'] as String;

    // Provide userId to the context for use in route handlers
    final updatedContext = context.provide<String>(() => userId);

    return handler(updatedContext);
  };
}
