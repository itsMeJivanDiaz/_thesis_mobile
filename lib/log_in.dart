import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class LoginQuery {
  String username = '';
  String password = '';
  List<dynamic> status = [];
  LoginQuery({
    required this.username,
    required this.password,
  });
  Future<void> postreq() async {
    Response response = await post(
        'http://${address.getip()}/cimo_desktop/app/mobile_login.php',
        body: {
          'data': 'true',
          'username': username,
          'password': password,
        });
    status = jsonDecode(response.body);
  }
}
