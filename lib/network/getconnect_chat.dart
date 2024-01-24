import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class GetConnectedChat extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://103.150.92.14:3001';
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