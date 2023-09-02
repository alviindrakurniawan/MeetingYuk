import 'package:meetingyuk/network/network_api_services.dart';


class BookingRepo {
  final ApiService _apiService = ApiService();



  //-per_page & current page setting
  Future<dynamic> getReservationHistory() async {
    final response = await _apiService.get(
      endpoint: '/reservations/history',
    );

    return response;
  }


  //get all reservation
  Future<dynamic> getReservation() async {
    Map<String, dynamic> customQuery = {'merchant': 'true'};
    final response = await _apiService.get(
        endpoint: '/reservations',
        query: customQuery
    );

    return response;
  }

}