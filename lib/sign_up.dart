import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class Signupquery {
  String region = '';
  String province = '';
  String city = '';
  String brgy = '';
  String username = '';
  String password = '';
  String status = '';
  Signupquery({
    required this.region,
    required this.province,
    required this.city,
    required this.brgy,
    required this.username,
    required this.password,
  });
  Future<void> postreq() async {
    Response response = await post(
        'http://${address.getip()}/cimo_desktop/app/mobile_sign_up.php',
        body: {
          'data': 'true',
          'region': region,
          'province': province,
          'city': city,
          'brgy': brgy,
          'username': username,
          'password': password,
        });
    status = jsonDecode(response.body);
  }
}
