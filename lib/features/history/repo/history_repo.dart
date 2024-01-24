import 'package:MeetingYuk/network/network_api_services.dart';

class HistoryRepository {
  final ApiService _apiService = ApiService();

  Future<dynamic> getAllReservation() async {
    Map<String, dynamic> customQuery = {"limit": "20"};
    final response = await _apiService.get(
      endpoint: '/reservations',
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

  Future<dynamic> getDetailReservation({required String reservationId}) async {
    final response = await _apiService.get(
      endpoint: '/reservations/$reservationId',
    );

    return response;
  }

  Future<dynamic> updateReservation(
      {required String reservation_id, required var body}) async {
    final response = await _apiService.put(
      endpoint: '/reservations/$reservation_id',
      body: body,
    );
    return response;
  }

  Future<dynamic> cancelReservation({required String reservation_id}) async {
    final response =
        await _apiService.put(endpoint: '/reservations/$reservation_id/cancel');
    return response;
  }

// Future<dynamic> getDetailRoom({required String placeId,required String roomId}) async {
//   final response = await _apiService.get(
//     endpoint: '/places/$placeId/rooms/$roomId',
//   );
//
//   return response;
// }
}
