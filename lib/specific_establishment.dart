import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class SpecificEstablishment {
  // ignore: non_constant_identifier_names
  String ref_id;
  List data = [];
  // ignore: non_constant_identifier_names
  SpecificEstablishment({required this.ref_id});
  Future<void> getSpec() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/general_api.php?eid=$ref_id');
    data = jsonDecode(response.body);
  }
}
