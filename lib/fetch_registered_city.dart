import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class FetchRegisteredCity {
  List data = [];
  Future<void> getData() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/fetch_cities.php?cities');
    data = jsonDecode(response.body);
  }
}
