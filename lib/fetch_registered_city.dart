import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';

class FetchRegisteredCity {
  List data = [];
  Future<void> getData() async {
    Response response =
        await get('http://192.168.254.131/cimo/web/fetch_cities.php?cities');
    data = jsonDecode(response.body);
  }
}
