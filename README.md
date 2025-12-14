# Flutter Chat App with Node.js & Socket.IO

A real-time chat application built with a **Flutter** frontend and a **Node.js** backend, utilizing **Socket.IO** for instant messaging.

## Features

- **Real-time Messaging**: Instant message delivery using Socket.IO.
- **User Authentication**: Secure login and registration (JWT/Bcrypt).
- **Local Database**: Offline support and caching using Isar.
- **State Management**: Scalable architecture with Flutter Bloc.
- **Connectivity**: Handles connection states (online/offline).

## Tech Stack

### Frontend (Flutter)

- **Framework**: Flutter
- **State Management**: `flutter_bloc`
- **Networking**: `dio`
- **Local Database**: `isar`
- **Routing**: `auto_route`
- **Code Generation**: `freezed`, `json_serializable`

### Backend (Node.js)

- **Runtime**: Node.js
- **Framework**: Express.js
- **Real-time Engine**: Socket.IO
- **Database**: MongoDB (via Mongoose)
- **Authentication**: `jsonwebtoken`, `bcryptjs`
