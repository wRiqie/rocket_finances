class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final double remainingBudget;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.remainingBudget = 0.0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photo_url': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photo_url'],
      remainingBudget: map['remaining_budget'] * 1.0,
    );
  }
}
