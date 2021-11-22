import 'package:shared_preferences/shared_preferences.dart';

class JwtPrefs {
  String setvar = '';
  String setval = '';
  String? res = '';
  JwtPrefs({
    required this.setvar,
    required this.setval,
  });
  Future<void> setjwt() async {
    final jwtprefs = await SharedPreferences.getInstance();
    jwtprefs.setString(this.setvar, this.setval);
  }

  Future<void> getjwt() async {
    final jwtprefs = await SharedPreferences.getInstance();
    res = jwtprefs.getString(this.setvar);
  }
}
