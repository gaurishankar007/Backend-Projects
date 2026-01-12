# Dart Frog API - Authentication & Todo App

A complete REST API built with Dart Frog featuring JWT authentication, MongoDB integration, and CRUD operations for todos.

## Features

- ✅ User signup and login with JWT tokens
- ✅ Access token (15 min) and refresh token (7 days)
- ✅ Protected todo CRUD operations
- ✅ MongoDB database with proper indexing
- ✅ Profile picture upload with static file serving
- ✅ Password hashing with bcrypt
- ✅ File-based routing middleware

## Prerequisites

- Dart SDK (>=3.0.0)
- MongoDB running locally or remotely
- Dart Frog CLI: `dart pub global activate dart_frog_cli`

## Installation

1. **Install dependencies:**
```bash
dart pub get
```

2. **Configure environment variables:**
Create a `.env` file in the root directory (already provided in artifacts).

3. **Start MongoDB:**
```bash
# If using Docker
docker run -d -p 27017:27017 --name mongodb mongo:latest

# Or start your local MongoDB instance
mongod --dbpath path/to/your/mongodb/database
```

4. **Run the server:**
```bash
dart_frog dev
```

The server will start at `http://localhost:8080`

## Project Structure

```
├── lib/
│   ├── models.dart          # User and Todo models
│   ├── database.dart        # MongoDB connection
│   └── jwt_service.dart     # JWT token management
├── routes/
│   ├── _middleware.dart     # Global middleware (DB + JWT setup)
│   ├── auth/
│   │   ├── signup.dart      # POST /auth/signup
│   │   ├── login.dart       # POST /auth/login
│   │   └── refresh.dart     # POST /auth/refresh
│   └── todos/
│       ├── _middleware.dart # Auth middleware for todos
│       ├── index.dart       # GET, POST /todos
│       └── [id].dart        # GET, PUT, DELETE /todos/:id
└── .env                     # Environment configuration
```

## API Testing

```bash
# 1. Sign up
curl -X POST http://localhost:8080/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com","password":"pass123"}'

# 2. Login (save the accessToken)
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"john@example.com","password":"pass123"}'

# 3. Create a todo (replace TOKEN with your accessToken)
curl -X POST http://localhost:8080/todos \
  -H "Authorization: Bearer TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test todo","description":"Testing"}'

# 4. Get all todos
curl -X GET http://localhost:8080/todos \
  -H "Authorization: Bearer TOKEN"

# 5. Refresh token
curl -X POST http://localhost:8080/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"refreshToken":"YOUR_REFRESH_TOKEN"}'
```

## How Middleware Works

1. **Root Middleware** (`routes/_middleware.dart`):
   - Runs for ALL routes
   - Initializes MongoDB connection
   - Creates JWT service
   - Provides them via context

2. **Todos Middleware** (`routes/todos/_middleware.dart`):
   - Uses shared `authMiddleware` from `api_data` package
   - Validates JWT and injects userId

3. **User Middleware** (`routes/user/_middleware.dart`):
   - Same shared auth logic for user routes

The middleware chain: `Root Middleware → Route Specific Middleware → Route Handler`

## Security Features

- Password hashing with bcrypt (cost factor 10)
- JWT tokens with expiration
- Separate access (15m) and refresh tokens (7d)
- Email uniqueness enforced at DB level
- User authorization (users can only access their own todos)
- Token type validation (access vs refresh)

## Production Considerations

1. **Connection Pooling**: Current implementation closes DB connection after each request. For production, use a connection pool.
2. **Environment Variables**: Store sensitive data in environment variables, never commit `.env` to git.
3. **Token Storage**: Refresh tokens should be stored securely (httpOnly cookies or secure storage).
4. **Rate Limiting**: Add rate limiting middleware to prevent abuse.
5. **HTTPS**: Always use HTTPS in production.
6. **Error Messages**: Don't expose internal errors to clients in production.

## License

MIT