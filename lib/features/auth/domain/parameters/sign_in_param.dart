class SignInParameter {
  final String email;
  final String password;

  const SignInParameter({required this.email, required this.password});
  Map<String, String> get toJson => {
        "email": email,
        "password": password,
      };
}
