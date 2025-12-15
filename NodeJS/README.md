# NodeJS Chat Backend

## Overview

This backend powers the Flutter Chat Application. It follows a **Layered Architecture** combining **OOP principles** for stateful components (Services, Repositories) and **Functional Programming** for stateless utilities.

It leverages modern tooling for robustness:

- **Dependency Injection**: Managed by `tsyringe` (declarative, decorator-based).
- **Validation**: Schema-based validation using `zod`.
- **Database**: Mongoose ODM.
- **Real-time**: Socket.IO integration.

## Project Structure

```text
src/
├── config/         # Database configuration
├── constants/      # Global constants and environment variables
├── controllers/    # Handles HTTP requests (thin layer)
├── interfaces/     # TypeScript interfaces
├── middleware/     # Auth, Validation, Error Handling
├── models/         # Mongoose Data Models
├── repository/     # Data Access Layer (Singletons)
├── routes/         # Route definitions (DI resolution)
├── services/       # Business Logic Layer (Injectable)
├── utils/          # Stateless functional utilities
├── validators/     # Zod Schemas
├── app.ts          # App configuration
└── server.ts       # Entry point (DI setup)
```

## Architecture Layers

### 1. Controllers (`src/controllers`)

**Role**: Entry point for HTTP requests.

- **Dependency Injection**: Receives `Services` via constructor.
- **Responsibility**: Minimal logic. Delegates to services and formats responses.
- **Validation**: Assumes valid data (handled by upstream middleware).

### 2. Services (`src/services`)

**Role**: The heart of the application (Business Logic).

- **Dependency Injection**: Receives `Repositories` via constructor.
- **Responsibility**: Orchestrates workflows (e.g., Register = Check Email -> Hash -> Save).
- **Stateless Utils**: Uses `src/utils` for hashing, tokens, etc.

### 3. Repositories (`src/repository`)

**Role**: Data Access Layer (DAL).

- **Singleton**: Annotated with `@singleton` for efficient reuse.
- **Responsibility**: Abstracts database queries from business logic.

### 4. Middleware

- **Validation (`validate.middleware.ts`)**: Generic middleware that validates requests against **Zod Schemas**.
- **Auth**: Verifies JWT tokens.

## Workflow

```mermaid
flowchart TD
    Request[HTTP Request] --> Router[Router]
    Router --> ValMiddleware[Validation Middleware, Zodç]
    ValMiddleware --> AuthMiddleware[Auth Middleware]
    AuthMiddleware --> Controller[Controller]

    subgraph Core Logic
    Controller -- Input Data --> Service[Service Layer]
    Service -- Logic execution --> Utility[Utils, Hash/Token]
    Service -- Data Request --> Repository[Repository Layer]
    end

    Repository -- Query --> Database[(MongoDB)]

    Repository -- Data --> Service
    Service -- Result --> Controller
    Controller -- JSON --> Response[HTTP Response]
```

## Dependency Injection (TSyringe)

We use **TSyringe** for declarative Dependency Injection.

- **Setup**: `import "reflect-metadata";` in `server.ts`.
- **Registration**: Decorate classes with `@singleton()` or `@injectable()`.
- **Resolution**: `container.resolve(Controller)` in routes auto-wires the dependency tree.

```typescript
// Example
@injectable()
export class UserController {
  constructor(private userService: UserService) {} // Auto-injected
}
```

## Setup & Run

1. `npm install`
2. `sudo npm install` (If permission errors occur)
3. `npm run dev` (Runs with `tsx` watch mode)
