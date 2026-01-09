import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService {
  final String secret;
  final Duration accessExpiry;
  final Duration refreshExpiry;

  JwtService({
    required this.secret,
    required this.accessExpiry,
    required this.refreshExpiry,
  });

  String generateAccessToken(String userId) {
    final jwt = JWT({
      'userId': userId,
      'type': 'access',
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
    });

    return jwt.sign(
      SecretKey(secret),
      expiresIn: accessExpiry,
    );
  }

  String generateRefreshToken(String userId) {
    final jwt = JWT({
      'userId': userId,
      'type': 'refresh',
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
    });

    return jwt.sign(
      SecretKey(secret),
      expiresIn: refreshExpiry,
    );
  }

  Map<String, String> generateTokens(String userId) {
    return {
      'accessToken': generateAccessToken(userId),
      'refreshToken': generateRefreshToken(userId),
    };
  }

  Map<String, dynamic>? verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(secret));
      return jwt.payload as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  String? extractUserId(String token) {
    final payload = verifyToken(token);
    return payload?['userId'] as String?;
  }
}

Duration parseDuration(String duration) {
  final regex = RegExp(r'^(\d+)([smhd])$');
  final match = regex.firstMatch(duration);

  if (match == null) {
    throw ArgumentError('Invalid duration format: $duration');
  }

  final value = int.parse(match.group(1)!);
  final unit = match.group(2)!;

  switch (unit) {
    case 's':
      return Duration(seconds: value);
    case 'm':
      return Duration(minutes: value);
    case 'h':
      return Duration(hours: value);
    case 'd':
      return Duration(days: value);
    default:
      throw ArgumentError('Invalid duration unit: $unit');
  }
}
