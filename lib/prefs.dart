import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  String value = '';
  String key = '';
  Prefs({required this.value, required this.key});
  String? res = '';
  Future<void> setter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.key, this.value);
  }

  Future<void> getter(getkey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove(getkey);
    res = prefs.getString(getkey);
  }
}
