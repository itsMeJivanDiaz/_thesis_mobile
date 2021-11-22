// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cimo_mobile/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class LogOut {
  String? token = '';
  String? key = '';
  LogOut({
    required this.token,
    required this.key,
  });
  Future<void> logout() async {
    Response response = await post(
      'http://${address.getip()}/cimo_desktop/app/force_log_out.php',
      body: {
        'token': this.token,
        'key': this.key,
        'mobile': 'true',
      },
    );
  }
}
