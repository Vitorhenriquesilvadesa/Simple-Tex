import 'package:simple_tex/misc/models/user_model.dart';

enum ModelType {
  user,
}

abstract class GenericModel {
  int id;

  GenericModel({required this.id});

  Map<String, dynamic> toMap();

  static T? getModel<T>(ModelType type, Map<String, dynamic> data) {
    if (type == ModelType.user) {
      return User.fromMap(data) as T;
    }

    return null;
  }
}
