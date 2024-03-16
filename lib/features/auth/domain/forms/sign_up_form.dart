class SignUpForm {
  final String name;
  final String email;
  final String password;

  const SignUpForm({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, String> get toJson => {
        "name": name,
        "email": email,
        "password": password,
      };
}
