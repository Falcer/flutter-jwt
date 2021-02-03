class User {
  String id;
  String name;
  String username;
  String email;

  User(this.id, this.name, this.username, this.email);

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      json["id"],
      json["name"],
      json["username"],
      json["email"],
    );
  }
}
