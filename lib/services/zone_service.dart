// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:kids_care/models/zone.dart';

class ZoneService {
  static String _url = 'http://198.199.72.194:1880/getZones';
  static Future browse() async {
    List collection = [];
    List<Zone> _contacts = [];
    var response = await http.get(_url);
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      _contacts = collection.map((json) => Zone.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return _contacts;
  }
}
