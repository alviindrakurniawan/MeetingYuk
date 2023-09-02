import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/network/app_exception.dart';
import 'package:meetingyuk/network/getconnect_cookie.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/network/getconnect_recommendation.dart';
import 'package:meetingyuk/ulits/app_url.dart';

class ApiService {
  final GetConnected _getConnect = Get.put(GetConnected());
  final GetConnectedRec _getConnectedRec = Get.put(GetConnectedRec());

  final storage = GetStorage();

  Future<String?> loadCookies() async {
    return storage.read('Cookie');
  }

  Future<void> saveCookies(Response response) async {
    String? rawCookie = response.headers?['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      String? cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      await storage.write('Cookie', cookie);
    }
  }

  Future<String> getCookieHeader() async {
    String? cookie = await loadCookies();
    return (cookie != null) ? cookie : '';
  }

  Future<Map<String, String>> getCustomHeaders(Map<String, String>? headers) async {
    Map<String, String> customHeaders = {};
    String cookieHeader = await getCookieHeader();
    if (cookieHeader.isNotEmpty) {
      customHeaders['Cookie'] = cookieHeader;
    }
    if (headers != null) {
      customHeaders.addAll(headers);
    }
    return customHeaders;
  }

  get<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {

    Map<String, String> customHeaders = await getCustomHeaders(headers);
    final response = await _getConnect.get(endpoint, headers: customHeaders, query: query);


    // if (!response.hasError) {
    //   return _returnResponse(response);
    // } else {
    //   if (response.body is Map && response.body.containsKey('message')) {
    //     throw _returnResponse(response);
    //   } else {
    //     throw AppExceptions('An error occurred', response.statusCode);
    //   }
    // }
    if (response.body is Map && response.body.containsKey('message')) {
      return _returnResponse(response);
    } else {
      throw AppExceptions('No Internet Connection');
    }

  }
  get2<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {

    Map<String, String> customHeaders = await getCustomHeaders(headers);
    final response = await _getConnectedRec.get(endpoint, headers: customHeaders, query: query);


    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      if (response.body is Map ) {
        throw AppExceptions(response.body['error']);
      } else {
        throw AppExceptions('An error occurred', response.statusCode);
      }
    }
  }

  post<T>({
    required String endpoint,
    dynamic body,
    Map<String, String>? headers,
    Map<String,dynamic>? query,
  }) async {

    Map<String, String> customHeaders = await getCustomHeaders(headers);
    final response = await _getConnect.post(endpoint, body, headers: customHeaders, query: query);
    await saveCookies(response);

    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      if (response.body is Map && response.body.containsKey('message')) {
        throw AppExceptions(response.body['message']);
      } else {
        throw AppExceptions('An error occurred', response.statusCode);
      }
    }
  }

  // post2<T>({
  //   required String endpoint,
  //   dynamic body,
  //   Map<String, String>? headers,
  //   Map<String,dynamic>? query,
  // }) async {
  //
  //   final response = await _getConnect.post(endpoint, body, headers: headers, query: query);
  //
  //   if (!response.hasError) {
  //     return _returnResponse(response);
  //   } else {
  //     if (response.body is Map && response.body.containsKey('message')) {
  //       throw AppExceptions(response.body['message']);
  //     } else {
  //       throw AppExceptions('An error occurred', response.statusCode);
  //     }
  //   }
  // }

  put<T>({
    required String endpoint,
    dynamic body,
    Map<String, String>? headers,
  }) async {

    Map<String, String> customHeaders = await getCustomHeaders(headers);
    final response = await _getConnect.put(endpoint, body, headers: customHeaders);

    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      if (response.body is Map && response.body.containsKey('message')) {
        throw AppExceptions(response.body['message']);
      } else {
        throw AppExceptions('An error occurred', response.statusCode);
      }
    }
  }


  delete<T>({
    required String endpoint,
    Map<String,dynamic>? body,
    Map<String, String>? headers,
  }) async {


    Map<String, String> customHeaders = await getCustomHeaders(headers);


    final response = await _getConnect.delete(endpoint,
        headers: customHeaders);


      return _returnResponse(response);
  }
}



dynamic _returnResponse(Response<dynamic> response){
  switch(response.statusCode){
    case 200:
      return response.body;
    case 201:
      return response.body;
    case 400:
      return response.body['message'] ;
    case 401:
      throw UnauthorizedException('Token Expired');
    case 403:
      throw ForbiddenException(response.body['message']);
    case 404:
      throw BadRequestException(response.body['message']);
    case 500:
      throw FetchDataException('Internal Server Error');
    case 501:
      return response.body ;
    default :
      throw FetchDataException('Error occurred while communicating with server ${response.statusCode}') ;
  }
}



