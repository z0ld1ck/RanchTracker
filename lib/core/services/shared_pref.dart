import 'package:shared_preferences/shared_preferences.dart';

final sharedPreference = SharedPreferenceHelper();

class SharedPreferenceHelper {
  late SharedPreferences _sharedPreference;

  Future<void> init() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _sharedPreference;

  bool get isAuthenticated => false;
}
