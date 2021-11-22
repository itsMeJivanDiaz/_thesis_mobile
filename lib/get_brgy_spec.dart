import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:cimo_mobile/ip.dart';

GetIp address = GetIp();

class BrgySpecificEstablishment {
  // ignore: non_constant_identifier_names
  String refid;
  List data = [];
  String? token = '';
  String? key = '';
  // ignore: non_constant_identifier_names
  BrgySpecificEstablishment({
    required this.refid,
    required this.token,
    required this.key,
  });
  Future<void> getBrgySpec() async {
    Response response = await get(
        'http://${address.getip()}/cimo_desktop/app/brgy_spec_est.php?est_id=$refid&&token=$token&&key=$key');
    data = jsonDecode(response.body);
    print(data);
  }
}
