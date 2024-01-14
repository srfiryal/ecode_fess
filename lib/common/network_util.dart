import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'shared_preferences_service.dart';

class NetworkUtil {
  static Future<dynamic> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return await _customNetwork(Constants.post, url, body, encoding, headers);
  }

  static Future<dynamic> get(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return await _customNetwork(Constants.get, url, body, encoding, headers);
  }

  static Future<dynamic> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return await _customNetwork(Constants.put, url, body, encoding, headers);
  }

  static Future<dynamic> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return await _customNetwork(Constants.delete, url, body, encoding, headers);
  }

  static Future<dynamic> _customNetwork(String type, Uri url, Object? body, Encoding? encoding, Map<String, String>? headers) async {
    String? token = SharedPreferencesService.getToken();
    headers ??= {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    Constants.logger.i('body $body $headers');

    http.Response res;
    switch (type) {
      case Constants.get:
        res = await http.get(url, headers: headers);
        break;
      case Constants.put:
        res = await http.put(url, body: body, headers: headers, encoding: encoding);
        break;
      case Constants.delete:
        res = await http.delete(url, body: body, headers: headers, encoding: encoding);
        break;
      default:
        res = await http.post(url, body: body, headers: headers, encoding: encoding);
    }

    Constants.logger.i('response test $url ${res.statusCode} ${res.body}');

    return res;
  }
}
