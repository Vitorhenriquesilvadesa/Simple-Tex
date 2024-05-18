import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:simple_tex/misc/repositories/settings.dart';

class SettingsPersistence {
  static SettingsPersistence instance = SettingsPersistence();

  static get getInstance => instance;

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    String localPath = directory.path;
    return File('$localPath/settings.json');
  }

  Future<bool> saveData(Settings settings) async {
    final localFile = await _getLocalFile();

    String data = json.encode(localFile);
    if (localFile.writeAsString(data) != null) {
      return true;
    }
    return false;
  }

  Future<Settings> getData() async {
    final localFile = await _getLocalFile();
    if (await localFile.exists()) {
      String data = await localFile.readAsString();
      List<dynamic> settingsMap = json.decode(data);

      Settings settings = Settings.fromMap(settingsMap[0]);
      return settings;
    } else {
      return Settings();
    }
  }
}
