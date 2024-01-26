class SignInPrm {
  final String email;
  final String password;

  const SignInPrm({required this.email, required this.password});
  Map<String, String> get toJson => {
        "email": email,
        "password": password,
      };
}
