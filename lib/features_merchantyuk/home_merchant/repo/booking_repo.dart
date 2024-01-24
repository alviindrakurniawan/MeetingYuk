import 'package:MeetingYuk/network/network_api_services.dart';


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

  Future<dynamic> accReservation({required String reservationId})async{
    final response = await _apiService.put(
        endpoint: '/reservations/$reservationId/accept',
    );
    return response;
  }

  Future<dynamic> rejectReservation({required String reservationId})async{
    final response = await _apiService.put(
      endpoint: '/reservations/$reservationId/reject',
    );
    return response;
  }

  Future<dynamic> updatePayment({required String reservationId})async{
    final response = await _apiService.put(
      endpoint: '/reservations/$reservationId/payments',
    );
    return response;
  }

  Future<dynamic> checkUser({required String userId})async{
    final response = await _apiService.get(
      endpoint: '/users/$userId',
    );
    return response;
  }



}