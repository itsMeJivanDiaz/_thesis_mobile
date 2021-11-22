import 'dart:collection';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class GetJsonAddr {
  Map<String, dynamic> addrdata = Map();
  Future<void> getaddr() async {
    Response response =
        await get('http://${address.getip()}/cimo_desktop/app/address.json');
    addrdata = jsonDecode(response.body);
  }
}
