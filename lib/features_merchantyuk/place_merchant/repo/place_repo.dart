

import 'package:MeetingYuk/network/network_api_services.dart';


class PlaceMerchantRepo {
  final ApiService _apiService = ApiService();


  Future<dynamic> getPlaceMerchant() async {
    Map<String, dynamic> customQuery = {'is_merchant':'true'};
    final response = await _apiService.get(
      endpoint: '/places',
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

  Future<dynamic> createPlace({required dynamic body}) async {
    final response = await _apiService.post(
      endpoint: '/places',
      body: body
    );
    return response;
  }

  Future<dynamic> updatePlace({required String placeId,required dynamic body}) async {
    final response = await _apiService.put(
      endpoint: '/places/$placeId',
      body: body
    );
    return response;
  }

  Future<dynamic> updateRoom({required String placeId,required String roomId,required dynamic body}) async {
    final response = await _apiService.put(
        endpoint: '/places/$placeId/rooms/$roomId',
        body: body
    );
    return response;
  }

  Future<dynamic> addRoom({required String placeId,required dynamic body}) async {
    final response = await _apiService.post(
        endpoint: '/places/$placeId/rooms',
        body: body
    );
    return response;
  }

  Future<dynamic> deletePlace({required String placeId}) async {
    final response = await _apiService.delete(
      endpoint: '/places/$placeId',
    );
    return response;
  }


  Future<dynamic> deleteRoom({required String placeId,required String roomId}) async {
    final response = await _apiService.delete(
        endpoint: '/places/$placeId/rooms/$roomId',
    );
    return response;

  }



}
