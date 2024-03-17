import 'package:all_notes/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void changeLoginState(bool value) async {
  String pref1Name = 'loginPrefs';
  late SharedPreferences loginPrefs;
  loginPrefs = await getSharedPreferences(pref1Name);
  await loginPrefs.setBool('loginState', value);
}
