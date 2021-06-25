class User {
  final int id;
  final String name;
  final String imageUrl;
  User({required this.id, required this.name, required this.imageUrl});
}

class UserSignUp {
  final String name;
  final String imageUrl;
  final String email;
  final String password;
  final String phone;
  final String occupation;

  UserSignUp({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.password,
    required this.phone,
    required this.occupation,
  });
}
