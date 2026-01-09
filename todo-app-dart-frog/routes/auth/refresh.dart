import 'package:api_data/src/services/jwt_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response.json(
      statusCode: 405,
      body: {'error': 'Method not allowed'},
    );
  }

  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final refreshToken = body['refreshToken'] as String?;

    if (refreshToken == null || refreshToken.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Refresh token is required'},
      );
    }

    final jwtService = context.read<JwtService>();

    // Verify refresh token
    final payload = jwtService.verifyToken(refreshToken);

    if (payload == null) {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid or expired refresh token'},
      );
    }

    // Check if it's actually a refresh token
    if (payload['type'] != 'refresh') {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid token type'},
      );
    }

    final userId = payload['userId'] as String;

    // Generate new access token
    final newAccessToken = jwtService.generateAccessToken(userId);

    return Response.json(
      body: {
        'message': 'Access token refreshed successfully',
        'accessToken': newAccessToken,
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Internal server error: $e'},
    );
  }
}
