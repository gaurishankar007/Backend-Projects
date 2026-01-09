import 'package:api_data/api_data.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  final userId = context.read<String>();
  final db = context.read<Database>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getTodos(context, db, userId);
    case HttpMethod.post:
      return _createTodo(context, db, userId);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response.json(
        statusCode: 405,
        body: {'error': 'Method not allowed'},
      );
  }
}

Future<Response> _getTodos(
  RequestContext context,
  Database db,
  String userId,
) async {
  try {
    final params = context.request.uri.queryParameters;
    final skip = int.tryParse(params['skip'] ?? '0') ?? 0;
    final limit = int.tryParse(params['limit'] ?? '10') ?? 10;

    final selector = where
        .eq('userId', userId)
        .sortBy('createdAt', descending: true)
        .skip(skip)
        .limit(limit);

    final todoDocs = await db.todos.find(selector).toList();

    final todos = todoDocs.map((doc) {
      final todo = Todo.fromJson(doc);
      return {
        'id': todo.id?.oid,
        'title': todo.title,
        'description': todo.description,
        'completed': todo.completed,
        'createdAt': todo.createdAt.toIso8601String(),
        'updatedAt': todo.updatedAt?.toIso8601String(),
      };
    }).toList();

    return Response.json(body: {'todos': todos});
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to fetch todos: $e'},
    );
  }
}

Future<Response> _createTodo(
  RequestContext context,
  Database db,
  String userId,
) async {
  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final title = body['title'] as String?;
    final description = body['description'] as String?;

    if (title == null || title.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Title is required'},
      );
    }

    final todo = Todo(
      userId: userId,
      title: title,
      description: description,
    );

    final result = await db.todos.insertOne(todo.toJson());
    final todoId = (result.id as ObjectId).oid;

    return Response.json(
      statusCode: 201,
      body: {
        'message': 'Todo created successfully',
        'todo': {
          'id': todoId,
          'title': title,
          'description': description,
          'completed': false,
          'createdAt': todo.createdAt.toIso8601String(),
        },
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to create todo: $e'},
    );
  }
}
