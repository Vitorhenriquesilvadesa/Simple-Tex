import 'package:get/get.dart';
import 'package:simple_tex/misc/models/pin_model.dart';
import 'package:simple_tex/misc/controllers/file_persistance.dart';

class PinController extends GetxController {
  List<Pin> pins = [];
  late String username;

  PinController(String userName) {
    username = userName;
    init(userName);
  }

  void init(String userName) async {
    pins = await FilePersistence.instance.getData(userName);
    update();
  }

  void setUser(String user) async {
    username = user;
    pins = await FilePersistence.instance.getData(user);
    update();
  }

  void addPin(Pin pin, String userName) {
    pins.add(pin);
    FilePersistence.instance.saveData(pins, userName);
    update();
  }

  void removePin(Pin pin, String userName) {
    pins.remove(pin);
    FilePersistence.instance.saveData(pins, userName);
    update();
  }

  void updatePin(int id, Pin newPin, String userName) {
    int index = pins.indexWhere((element) => element.id == id);
    pins[index] = newPin;
    FilePersistence.instance.saveData(pins, userName);
    update();
  }

  Pin? getById(int id) {
    return pins.firstWhere((element) => element.id == id);
  }

  List<Pin> getAll() {
    return pins;
  }
}
