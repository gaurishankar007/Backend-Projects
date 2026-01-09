import 'package:api_data/api_data.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final userId = context.read<String>();
  final db = context.read<Database>();

  // Validate ObjectId
  if (!ObjectId.isValidHexId(id)) {
    return Response.json(
      statusCode: 400,
      body: {'error': 'Invalid todo ID'},
    );
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return _getTodo(db, userId, id);
    case HttpMethod.put:
      return _updateTodo(context, db, userId, id);
    case HttpMethod.delete:
      return _deleteTodo(db, userId, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response.json(
        statusCode: 405,
        body: {'error': 'Method not allowed'},
      );
  }
}

Future<Response> _getTodo(Database db, String userId, String id) async {
  try {
    final todoDoc = await db.todos.findOne({
      '_id': ObjectId.fromHexString(id),
      'userId': userId,
    });

    if (todoDoc == null) {
      return Response.json(
        statusCode: 404,
        body: {'error': 'Todo not found'},
      );
    }

    final todo = Todo.fromJson(todoDoc);

    return Response.json(
      body: {
        'todo': {
          'id': todo.id?.oid,
          'title': todo.title,
          'description': todo.description,
          'completed': todo.completed,
          'createdAt': todo.createdAt.toIso8601String(),
          'updatedAt': todo.updatedAt?.toIso8601String(),
        },
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to fetch todo: $e'},
    );
  }
}

Future<Response> _updateTodo(
  RequestContext context,
  Database db,
  String userId,
  String id,
) async {
  try {
    final body = await context.request.json() as Map<String, dynamic>;

    // Check if todo exists and belongs to user
    final existingDoc = await db.todos.findOne({
      '_id': ObjectId.fromHexString(id),
      'userId': userId,
    });

    if (existingDoc == null) {
      return Response.json(
        statusCode: 404,
        body: {'error': 'Todo not found'},
      );
    }

    final updateFields = <String, dynamic>{
      'updatedAt': DateTime.now().toIso8601String(),
    };

    if (body.containsKey('title')) {
      final title = body['title'] as String?;
      if (title == null || title.isEmpty) {
        return Response.json(
          statusCode: 400,
          body: {'error': 'Title cannot be empty'},
        );
      }
      updateFields['title'] = title;
    }

    if (body.containsKey('description')) {
      updateFields['description'] = body['description'];
    }

    if (body.containsKey('completed')) {
      updateFields['completed'] = body['completed'] as bool;
    }

    await db.todos.updateOne(
      {'_id': ObjectId.fromHexString(id)},
      {r'$set': updateFields},
    );

    // Fetch updated todo
    final updatedDoc =
        await db.todos.findOne({'_id': ObjectId.fromHexString(id)});
    final updatedTodo = Todo.fromJson(updatedDoc!);

    return Response.json(
      body: {
        'message': 'Todo updated successfully',
        'todo': {
          'id': updatedTodo.id?.oid,
          'title': updatedTodo.title,
          'description': updatedTodo.description,
          'completed': updatedTodo.completed,
          'createdAt': updatedTodo.createdAt.toIso8601String(),
          'updatedAt': updatedTodo.updatedAt?.toIso8601String(),
        },
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to update todo: $e'},
    );
  }
}

Future<Response> _deleteTodo(Database db, String userId, String id) async {
  try {
    final result = await db.todos.deleteOne({
      '_id': ObjectId.fromHexString(id),
      'userId': userId,
    });

    if (result.nRemoved == 0) {
      return Response.json(
        statusCode: 404,
        body: {'error': 'Todo not found'},
      );
    }

    return Response.json(
      body: {'message': 'Todo deleted successfully'},
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to delete todo: $e'},
    );
  }
}
