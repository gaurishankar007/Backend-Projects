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
mongod
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

## API Endpoints

### Authentication

#### 1. Sign Up
```bash
POST /auth/signup
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}

# Response:
{
  "message": "User created successfully",
  "user": {
    "id": "...",
    "name": "John Doe",
    "email": "john@example.com"
  },
  "accessToken": "eyJhbG...",
  "refreshToken": "eyJhbG..."
}
```

#### 2. Login
```bash
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}

# Response:
{
  "message": "Login successful",
  "user": { ... },
  "accessToken": "eyJhbG...",
  "refreshToken": "eyJhbG..."
}
```

#### 3. Refresh Access Token
```bash
POST /auth/refresh
Content-Type: application/json

{
  "refreshToken": "eyJhbG..."
}

# Response:
{
  "message": "Access token refreshed successfully",
  "accessToken": "eyJhbG..."
}
```

### Todos (Protected Routes)

All todo endpoints require `Authorization: Bearer <accessToken>` header.

#### 4. Get All Todos
```bash
GET /todos
Authorization: Bearer eyJhbG...

# Response:
{
  "todos": [
    {
      "id": "...",
      "title": "Buy groceries",
      "description": "Milk, eggs, bread",
      "completed": false,
      "createdAt": "2024-01-15T10:30:00.000Z"
    }
  ]
}
```

#### 5. Create Todo
```bash
POST /todos
Authorization: Bearer eyJhbG...
Content-Type: application/json

{
  "title": "Buy groceries",
  "description": "Milk, eggs, bread"
}

# Response:
{
  "message": "Todo created successfully",
  "todo": { ... }
}
```

#### 6. Get Single Todo
```bash
GET /todos/:id
Authorization: Bearer eyJhbG...

# Response:
{
  "todo": { ... }
}
```

#### 7. Update Todo
```bash
PUT /todos/:id
Authorization: Bearer eyJhbG...
Content-Type: application/json

{
  "title": "Buy groceries (updated)",
  "completed": true
}

# Response:
{
  "message": "Todo updated successfully",
  "todo": { ... }
}
```

#### 8. Delete Todo
```bash
DELETE /todos/:id
Authorization: Bearer eyJhbG...

# Response:
{
  "message": "Todo deleted successfully"
}
```

## Testing with cURL

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