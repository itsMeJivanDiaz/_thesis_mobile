// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class JwtChecker {
  String? status = '';
  String? key = '';
  String? id = '';
  List<dynamic> jwt = [];
  JwtChecker({required this.status, required this.key, required this.id});
  Future<void> check() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/mobile_jwt_checker.php?get_jwt=$status&&get_key=$key&&get_id=$id');
    jwt = jsonDecode(response.body);
    print(jwt);
  }
}
