import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:simple_tex/misc/models/user_model.dart';
import 'package:simple_tex/misc/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _repository;
  List<User> _users = [];
  List<User> get users => _users;

  UserController({required UserRepository repository})
      : _repository = repository;

  Future<void> getAll() async {
    _users = [];
    _users = await _repository.getAll();
    update();
  }

  Future<void> add(User user) async {
    await _repository.add(user);
    await getAll();
    update();
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    await getAll();
    update();
  }

  Future<void> updateAll(User user) async {
    await _repository.update(user);
    await getAll();
    update();
  }

  void deleteModel(User user) async {
    _repository.deleteModel(user);
    await getAll();
    update();
  }
}
