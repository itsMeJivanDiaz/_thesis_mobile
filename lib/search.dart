import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class SearchEstablishment {
  // ignore: non_constant_identifier_names
  String search;
  String city;
  String? token = '';
  String? key = '';
  String? id = '';
  List<dynamic> data = [];
  // ignore: non_constant_identifier_names
  SearchEstablishment({
    required this.search,
    required this.city,
    required this.token,
    required this.key,
    required this.id,
  });
  Future<void> getsearch() async {
    if (search == "") {
      Response response = await get(
          'http://${address.getip()}/cimo_desktop/app/general_api.php?all&&token=$token&&key=$key&&id=$id');
      data = jsonDecode(response.body);
      print(data);
    } else if (search != "") {
      Response response = await get(
          'http://${address.getip()}/cimo_desktop/app/general_api.php?search=$search&&city=$city&&token=$token&&key=$key&&id=$id');
      data = jsonDecode(response.body);
    }
  }
}
