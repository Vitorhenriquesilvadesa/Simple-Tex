import 'package:simple_tex/misc/models/generic_model.dart';

class User extends GenericModel {
  String name;
  String password;

  User({required this.name, required super.id, required this.password});

  factory User.fromMap(Map<String, dynamic> map) {
    int id = map['id'];
    User user = User(id: id, name: map['name'], password: map['password']);
    return user;
  }

  @override
  String toString() {
    return "User { 'name': $name, 'password': $password }";
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'password': password,
    };

    return map;
  }
}
