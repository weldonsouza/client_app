import 'package:shared_preferences/shared_preferences.dart';

class UserLocal {
  static const String TOKEN = 'token';
  static const String TOKENGOOGLE = 'tokengoogle';

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(TOKEN);
    return token;
  }

  Future<String?> getAuthTokenGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(TOKENGOOGLE);
    return token;
  }

  Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }

  Future<void> saveAuthTokenGoogle(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKENGOOGLE, token);
  }

  Future<void> logout() async {
    saveAuthToken('');
    saveAuthTokenGoogle('');
  }
}
