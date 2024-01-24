import 'package:MeetingYuk/network/network_api_services.dart';

class ReservationRepository {
  final ApiService _apiService = ApiService();

  Future<dynamic> checkAvailability(
      {required String placeId,required String roomId, required String selected_date}) async {
    final response = await _apiService.get(
        endpoint: '/reservations/places/$placeId/rooms/$roomId',
        query: {'date': selected_date});

    return response;
  }

  Future<dynamic> createReservation(var body) async {
    final response =
        await _apiService.post(endpoint: '/reservations', body: body);

    return response;
  }

  Future<dynamic> updateReservation({required var body,required String reservationId}) async {
    final response =
    await _apiService.put(endpoint: '/reservations/$reservationId', body: body);

    return response;
  }

  Future<dynamic> addParticipant({required String id}) async{
    final response = await _apiService.get(endpoint: '/users/$id');

    return response;
  }
}
