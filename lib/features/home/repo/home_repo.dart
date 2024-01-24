import 'package:MeetingYuk/network/network_api_services.dart';


class HomeRepository {
  final ApiService _apiService = ApiService();


  Future<dynamic> getNearMe({required String lat, required String long, required String max_radius}) async {
    Map<String, dynamic> customQuery = {'max_returns':'15','max_radius':max_radius};
    final response = await _apiService.get2(
      endpoint: '/near_recs/$lat,$long',
      query: customQuery,
    );

    return response;
  }


  //-per_page & current page setting
  Future<dynamic> getReservationHistory() async {
    final response = await _apiService.get(
      endpoint: '/reservations/history',
    );

    return response;
  }




  //get all place
  Future<dynamic> searchPlace({required search, int page=1, int limit=25}) async {
    Map<String, dynamic> customQuery = {'page': '$page', 'limit': '$limit','search':'$search'};
    final response = await _apiService.get(
        endpoint: '/places',
        query: customQuery
    );

    return response;
  }

  Future<dynamic> getAllPlace() async {

    final response = await _apiService.get(
        endpoint: '/places',

    );

    return response;
  }

  Future<dynamic> getDetailPlace({required String placeId}) async {
    final response = await _apiService.get(
      endpoint: '/places/$placeId',
    );

    return response;
  }

  Future<dynamic> getRoomDetail({required String placeId,required String roomId}) async {
    final response = await _apiService.get(endpoint: '/places/:$placeId/rooms/:$roomId');
    return response;
  }





}
