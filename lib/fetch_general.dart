import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';

class FetchGeneralData {
  List data = [];
  Future<void> getData() async {
    Response response =
        await get('http://192.168.254.131/cimo/web/general_api.php?all');
    data = jsonDecode(response.body);
  }
}
