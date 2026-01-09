import 'package:api_data/api_data.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response.json(
      statusCode: 405,
      body: {'error': 'Method not allowed'},
    );
  }

  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final name = body['name'] as String?;
    final email = body['email'] as String?;
    final password = body['password'] as String?;

    // Validation
    if (name == null || name.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Name is required'},
      );
    }

    if (email == null || email.isEmpty || !_isValidEmail(email)) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Valid email is required'},
      );
    }

    if (password == null || password.length < 6) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Password must be at least 6 characters'},
      );
    }

    final db = context.read<Database>();
    final jwtService = context.read<JwtService>();

    // Check if user already exists
    final existingUser = await db.users.findOne({'email': email});
    if (existingUser != null) {
      return Response.json(
        statusCode: 409,
        body: {'error': 'User with this email already exists'},
      );
    }

    // Hash password
    final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    // Create user
    final user = User(
      name: name,
      email: email,
      password: hashedPassword,
    );

    final result = await db.users.insertOne(user.toJson());
    final userId = (result.id as ObjectId).oid;

    // Generate tokens
    final tokens = jwtService.generateTokens(userId);

    return Response.json(
      statusCode: 201,
      body: {
        'message': 'User created successfully',
        'user': {
          'id': userId,
          'name': name,
          'email': email,
        },
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

bool _isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}
