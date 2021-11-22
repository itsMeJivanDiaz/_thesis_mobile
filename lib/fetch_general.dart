import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class FetchGeneralData {
  String? token = '';
  String? key = '';
  String? id = '';
  FetchGeneralData({required this.token, required this.key, required this.id});
  List data = [];
  Future<void> getData() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/general_api.php?all&&token=$token&&key=$key&&id=$id');
    data = jsonDecode(response.body);
  }
}
