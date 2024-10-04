import 'package:shared_preferences/shared_preferences.dart';

class User {
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';

  static Future<void> saveUserInfo(String firstName, String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstNameKey, firstName);
    await prefs.setString(_lastNameKey, lastName);
  }

  // Retrieve the user information from SharedPreferences
  static Future<String> getFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_firstNameKey) ?? "";
  }

  // Retrieve the user information from SharedPreferences
  static Future<String> getLastName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastNameKey) ?? "";
  }

  // Deletes the user information from SharedPreferences
  static Future<void> deleteUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_firstNameKey);
    await prefs.remove(_lastNameKey);
  }
}
