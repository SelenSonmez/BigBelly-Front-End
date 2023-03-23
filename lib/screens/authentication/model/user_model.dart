class User {
  final int id;
  final String username;

  User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
      };
}
