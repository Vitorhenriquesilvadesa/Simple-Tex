import '../controllers/settings_manager.dart';

class Settings {
  String? backgroundImagePath;

  static Settings instance = Settings();

  Settings() {
    backgroundImagePath = "res/images/background002.jpeg";
  }

  static Future<void> init() async {
    instance = await SettingsPersistence.instance.getData();
  }

  Settings.fromMap(Map<String, dynamic> map) {
    backgroundImagePath = map['background'];
  }
}

String userName = "";
