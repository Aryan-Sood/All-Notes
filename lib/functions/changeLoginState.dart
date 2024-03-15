import 'package:shared_preferences/shared_preferences.dart';

void changeLoginState(bool value) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await sharedPreferences.setBool('loginState', value);
}
