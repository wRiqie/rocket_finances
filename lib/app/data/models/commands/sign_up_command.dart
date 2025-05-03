class SignUpCommand {
  final String email;
  final String password;
  final String name;

  SignUpCommand(
      {required this.email, required this.password, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }
}
