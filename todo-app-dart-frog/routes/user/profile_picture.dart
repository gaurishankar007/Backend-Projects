import 'dart:io';

import 'package:api_data/src/config/database.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post &&
      context.request.method != HttpMethod.put) {
    return Response.json(
      statusCode: 405,
      body: {'error': 'Method not allowed'},
    );
  }

  final contentType = context.request.headers['content-type'] ?? '';
  if (!contentType.contains('multipart/form-data')) {
    return Response.json(
      statusCode: 400,
      body: {'error': 'Content-Type must be multipart/form-data'},
    );
  }

  try {
    final userId = context.read<String>();
    final db = context.read<Database>();

    final formData = await context.request.formData();
    final image = formData.files['image'];

    if (image == null) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'No image file provided'},
      );
    }

    // Ensure public/uploads directory exists
    final publicDir = Directory('${Directory.current.path}/public/uploads');
    if (!publicDir.existsSync()) {
      publicDir.createSync(recursive: true);
    }

    // Generate unique filename
    final filename = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
    final filePath = '${publicDir.path}/$filename';
    final file = File(filePath);

    await file.writeAsBytes(await image.readAsBytes());

    final dbPath = '/uploads/$filename';

    await db.users.updateOne(
      {'_id': ObjectId.fromHexString(userId)},
      {
        r'$set': {'profilePicture': dbPath},
      },
    );

    return Response.json(body: {'profilePicture': dbPath});
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to upload profile picture: $e'},
    );
  }
}
