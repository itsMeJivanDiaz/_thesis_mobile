import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class SearchEstablishment {
  // ignore: non_constant_identifier_names
  String search;
  String city;
  List data = [];
  // ignore: non_constant_identifier_names
  SearchEstablishment({
    required this.search,
    required this.city,
  });
  Future<void> getsearch() async {
    if (search == "") {
      Response response = await get(
          'http://${address.getip()}/cimo_desktop/app/general_api.php?all');
      data = jsonDecode(response.body);
    } else if (search != "") {
      Response response = await get(
          'http://${address.getip()}/cimo_desktop/app/general_api.php?search=$search&&city=$city');
      data = jsonDecode(response.body);
    }
  }
}
