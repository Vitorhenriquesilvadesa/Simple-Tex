import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:simple_tex/misc/models/pin_model.dart';

class FilePersistence {
  static FilePersistence instance = FilePersistence();

  static get getInstance => instance;

  Future<File> _getLocalFile(String userName) async {
    final directory = await getApplicationDocumentsDirectory();
    String localPath = directory.path;
    File file = File('$localPath/editor/$userName.json');

    if (!await file.exists()) {
      file.createSync(recursive: true);
      file.writeAsStringSync("[]");
    }

    return file;
  }

  Future<bool> saveData(List<Pin> pins, userName) async {
    final localFile = await _getLocalFile(userName);
    List mapPins = List.empty(growable: true);
    for (Pin pin in pins) {
      mapPins.add(pin.toMap());
    }
    String data = json.encode(mapPins);
    if (localFile.writeAsString(data) != null) {
      return true;
    }
    return false;
  }

  Future<List<Pin>> getData(String userName) async {
    final localFile = await _getLocalFile(userName);
    List<dynamic> mapPins = [];
    List<Pin> pins = [];

    String data = await localFile.readAsString();
    mapPins = json.decode(data);

    for (Map<String, dynamic> mapPin in mapPins) {
      pins.add(Pin.fromMap(mapPin));
    }

    return pins;
  }
}
