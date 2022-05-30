import 'dart:convert';

class UserModel {
  String voterId;
  String name;
  int age;
  String password;

  UserModel(
    this.voterId,
    this.name,
    this.age,
    this.password,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(map['voterId'] ?? '', map['name'] ?? 'noname',
        map['age']?.toInt() ?? 0, map['password']);
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(voterId: $voterId, name: $name, age: $age)';
}
