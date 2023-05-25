
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void saveInt (String name, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(name, value);
  }

  void saveString (String name, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
  }

  Future<Object> readInt (String name, int defaultd) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(name) ?? defaultd;
  }

  Future<int> readString (String name, var defaultd) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(name) ?? defaultd;
  }

  void saveDouble (String name, var value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(name, value);
  }

  void saveStrlist (var name, var value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(name, value);
  }

  Future<Object> readDouble (String name, double defaultd) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(name) ?? defaultd;
  }

  void saveBool(String name, bool value) async {

  }

  Future<Object> readBool (String name, bool defaultd) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(name) ?? defaultd;
  }

  void remove(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
  }
}




//!https://stackoverflow.com/questions/52831605/flutter-shared-preferences
