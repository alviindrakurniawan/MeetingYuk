import 'package:get/get.dart';

import 'package:get/get_connect/http/src/request/request.dart';

class GetConnected extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://api.meetingyuk.com';
    httpClient.defaultContentType= "application/json";
    httpClient.timeout=const Duration(seconds:20);
    httpClient.addRequestModifier((Request request) async {
      print('Request +++');
      print('    Url: ${request.url}');
      print('    Headers: ${request.headers}');
      print('    Method: ${request.method}');
      print('Request ++');
      return request;
    });
    httpClient.addResponseModifier((request, response) async {
      print('Response +++');
      print('    StatusCode: ${response.statusCode}');
      print('    Headers: ${response.headers}');
      print('    Body: ${response.body}');
      print('Response ++');

      return response;
      });
    }

  }




// IF COOKIE FORMATED LIKE Cookie: token= askladsdjad

// import 'package:get/get.dart';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
//
// class CookieGetConnect extends GetConnect {
//   final CookieJar cookieJar = CookieJar();
//
//   @override
//   void onInit() {
//     httpClient.baseUrl = 'https://api.meetingyuk.site/';
//
//     httpClient.addRequestModifier((Request request) async {
//       List<Cookie> cookies = await cookieJar.loadForRequest(request.url);
//       if (cookies.isNotEmpty) {
//         request.headers['Cookie'] = cookies.join('; ');
//       }
//       return request;
//     });
//
//     httpClient.addResponseModifier((request, response) async {
//       String? rawCookie = response.headers?['Set-Cookie'];
//       if (rawCookie != null) {
//         int startIndex = rawCookie.indexOf('token=');
//         if (startIndex != -1) {
//           startIndex += 6; // Length of 'token='
//           int endIndex = rawCookie.indexOf(';', startIndex);
//           if (endIndex > startIndex) {
//             String token = rawCookie.substring(startIndex, endIndex);
//             Cookie cookie = Cookie('token', token);
//             await cookieJar.saveFromResponse(request.url, [cookie]);
//           }
//         }
//       }
//       if (response.statusCode == 401) {
//         Get.offAllNamed('/login'); // replace with your login route
//       }
//     });
//   }
// }


//IF COOKIE FORMATED LIKE Cookie:adfkalsdfjlasdjflasdjfl

// import 'package:get/get.dart';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
//
// class CookieGetConnect extends GetConnect {
//   final CookieJar cookieJar = CookieJar();
//
//   @override
//   void onInit() {
//     httpClient.baseUrl = 'https://api.meetingyuk.site/';
//
//     httpClient.addRequestModifier((Request request) async {
//       List<Cookie> cookies = await cookieJar.loadForRequest(request.url);
//       if (cookies.isNotEmpty) {
//         var token = cookies.firstWhere((cookie) => cookie.name == 'token', orElse: () => null);
//         if (token != null) {
//           request.headers['Cookie'] = token.value;
//         }
//       }
//       return request;
//     });
//
//     httpClient.addResponseModifier((request, response) async {
//       String? rawCookie = response.headers?['set-cookie'];
//       if (rawCookie != null) {
//         int startIndex = rawCookie.indexOf('token=');
//         if (startIndex != -1) {
//           startIndex += 6; // Length of 'token='
//           int endIndex = rawCookie.indexOf(';', startIndex);
//           if (endIndex > startIndex) {
//             String token = rawCookie.substring(startIndex, endIndex);
//             Cookie cookie = new Cookie('token', token);
//             await cookieJar.saveFromResponse(request.url, [cookie]);
//           }
//         }
//       }
//       if (response.statusCode == 401) {
//         Get.offAllNamed('/login'); // replace with your login route
//       }
//     });
//   }
// }
