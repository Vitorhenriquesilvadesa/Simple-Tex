import 'package:simple_tex/misc/repositories/generic_repository.dart';

import '../models/user_model.dart';

class UserRepository extends GenericRepository<User> {
  UserRepository({required super.tableName});
}
