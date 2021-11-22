// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cimo_mobile/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class JWT {
  String? status = '';
  String? key = '';
  String? id = '';
  JWT({required this.status, required this.key, required this.id});
  List<dynamic> jwt = [];
  Future<void> getjwt() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/mobile_jwt.php?get_jwt=$status&&get_key=$key&&get_id=$id');
    jwt = jsonDecode(response.body);
    if (jwt[0]['status'] == 'new') {
      Prefs token = Prefs(value: jwt[0]['jwt'], key: 'token');
      Prefs key = Prefs(value: jwt[0]['key'], key: 'key');
      Prefs id = Prefs(value: jwt[0]['tok_id'], key: 'id');
      await token.setter();
      await key.setter();
      await id.setter();
    }
  }
}
