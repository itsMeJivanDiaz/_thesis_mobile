import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class BrgySearch {
  String search = '';
  String? token = '';
  String? secretkey = '';
  List<dynamic> status = [];
  BrgySearch({
    required this.search,
    required this.token,
    required this.secretkey,
  });
  Future<void> brgysrch() async {
    Response response = await post(
      'http://${address.getip()}/cimo_desktop/app/brgy_search.php?search=$search',
      body: {
        'search': this.search,
        'token': this.token,
        'key': this.secretkey,
      },
    );
    status = jsonDecode(response.body);
  }
}
