import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cimo_mobile/brgy_home.dart';
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class BrygyFetch {
  String? token = '';
  String? secretkey = '';
  List<dynamic> status = [];
  BrygyFetch({required this.token, required this.secretkey});
  Future<void> fetchest() async {
    Response response = await post(
      'http://${address.getip()}/cimo_desktop/app/fetch_brgy_est.php',
      body: {
        'token': token,
        'key': secretkey,
      },
    );
    status = jsonDecode(response.body);
  }
}
