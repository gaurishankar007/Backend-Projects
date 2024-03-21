part of 'auth_cubit.dart';

class AuthState {
  final String error;

  const AuthState({required this.error});

  factory AuthState.initial() => const AuthState(error: "");
  
  AuthState copyWith({String? error}) => AuthState(error: error ?? this.error);

  @override
  bool operator ==(covariant AuthState other) => other.error == error;

  @override
  int get hashCode => error.hashCode;
}
