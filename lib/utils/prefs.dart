import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtils extends ChangeNotifier {
  static SharedPreferences preInstance;
  static Future<SharedPreferences> get _instance async =>
      preInstance ??= await SharedPreferences.getInstance();
  static Future<SharedPreferences> init() async {
    preInstance = await _instance;
    return preInstance;
  }

  static getAllKeys() {
    return preInstance.getKeys();
  }

  static String getString({String key}) {
    return preInstance.getString(key);
  }

  String _uid;
  String _name;
  String get name => _name;
  String get uid => _uid;
  getStringuid() {
    _uid = preInstance.getString("uid");
    _name = preInstance.getString('name');
    print(_uid);
    print(_name);
    notifyListeners();
  }
}
