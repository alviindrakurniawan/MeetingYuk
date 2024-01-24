
import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MeetingYuk/network/app_exception.dart';
import 'package:MeetingYuk/network/getconnect_cookie.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServiceHttp {
  final _baseUrl = 'api.meetingyuk.site';

  final storage = GetStorage();

  Future<String?> _loadCookies() async {
    return storage.read('Cookie').toString();
  }

  Future<void> _saveCookies(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      String? cookie = (index == -1) ? rawCookie : rawCookie.substring(
          0, index);
      await storage.write('Cookie', cookie);
    }
  }

  Future<Map<String, String>> get headers async {
    String? cookie = await _loadCookies();
    if (cookie != null) {
      return {
        'Content-Type': 'application/json',
        'Cookie': cookie,
      };
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }


  Future<http.Response> get(String endpoint,
      {Map<String, String>? query}) async {
    final uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(
      uri,
      headers: await headers,
    );
    return _returnResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic body,
      {Map<String, String>? query}) async {
    dynamic responseJson;

    final uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: await headers,
    );
    await _saveCookies(response);
    responseJson = _returnResponse(response);
    return responseJson;

  }

  Future<http.Response> put(String endpoint, dynamic body) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      body: body,
      headers: await headers,
    );
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: await headers,
    );
    return response;
  }


  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
      //2 is number of message data
      //throw to login screen
        throw UnauthorizedException(response.body[2]);
      case 403:
        throw ForbiddenException(response.body[2]);
      case 404:
        throw BadRequestException(response.body[2]);
      case 500:
        throw FetchDataException('Internal Server Error');
      default :
        throw FetchDataException(
            'Error occurred while communicating with server ${response
                .statusCode}');
    }
  }
}
