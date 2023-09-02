import 'package:get/get.dart';
import 'package:meetingyuk/network/network_api_services.dart';

class ExploreRepository {
  final ApiService _apiService = ApiService();
  var loading = false.obs;


  Future<dynamic> getForYouRec() async {
    Map<String, dynamic> customQuery = {"max_returns": "10"};
    final response = await _apiService.get(
      endpoint: '/recommendation/cxuxXkcihfCbqt5Byrup8Q',
      query: customQuery,
    );

    return response;
  }

  Future<dynamic> getForYouLocation({required String lat, required String long, required String max_radius}) async {
    Map<String, dynamic> customQuery = {'max_returns':'15', 'latitude':lat,'longitude':long,'max_radius':max_radius};
    final response = await _apiService.get2(
      endpoint: '/recommendation/cxuxXkcihfCbqt5Byrup8Q',
      query: customQuery,
    );

    return response;
  }

  Future<dynamic> getDetailPlace({required String placeId}) async {
    final response = await _apiService.get(
      endpoint: '/places/$placeId',
    );

    return response;
  }







}
