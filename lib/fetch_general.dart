import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class FetchGeneralData {
  List data = [];
  Future<void> getData() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/general_api.php?all');
    data = jsonDecode(response.body);
  }
}
