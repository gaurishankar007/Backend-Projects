import 'package:api_data/api_data.dart';
import 'package:bcrypt/bcrypt.dart';
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
    final email = body['email'] as String?;
    final password = body['password'] as String?;

    // Validation
    if (email == null || email.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Email is required'},
      );
    }

    if (password == null || password.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Password is required'},
      );
    }

    final db = context.read<Database>();
    final jwtService = context.read<JwtService>();

    // Find user
    final userDoc = await db.users.findOne({'email': email});
    if (userDoc == null) {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid email or password'},
      );
    }

    final user = User.fromJson(userDoc);

    // Verify password
    final isPasswordValid = BCrypt.checkpw(password, user.password);
    if (!isPasswordValid) {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid email or password'},
      );
    }

    // Generate tokens
    final userId = user.id!.oid;
    final tokens = jwtService.generateTokens(userId);

    return Response.json(
      body: {
        'message': 'Login successful',
        'user': user.toSafeJson(),
        'accessToken': tokens['accessToken'],
        'refreshToken': tokens['refreshToken'],
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Internal server error: $e'},
    );
  }
}
