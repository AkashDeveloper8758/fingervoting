import 'dart:convert';

class UserModel {
  String? voterId;
  String? name;
  int? age;
  UserModel({
    this.voterId,
    this.name,
    this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'voterId': voterId,
      'name': name,
      'age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      voterId: map['voterId'],
      name: map['name'],
      age: map['age']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(voterId: $voterId, name: $name, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.voterId == voterId;
  }

  @override
  int get hashCode => voterId.hashCode ^ name.hashCode ^ age.hashCode;
}
