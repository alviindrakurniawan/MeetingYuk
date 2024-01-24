import 'package:MeetingYuk/network/network_api_services.dart';

class ChatRepo {
  final ApiService _apiService = ApiService();

  Future<dynamic> getChat(String id) async {
    final response = await _apiService.getChat(endpoint: '/chat/$id');

    return response;
  }

  Future<dynamic> checkExistingChat() async {
    final response = await _apiService.getChat(endpoint: '/chat');

    return response;
  }

  Future<dynamic> getMessage(String id) async {
    final response = await _apiService.getChat(endpoint: '/message/$id');

    return response;
  }

  Future<dynamic> postInitChat(var body) async {
    final response = await _apiService.postChat(endpoint: '/chat', body: body);

    return response;
  }

  Future<dynamic> postMessage(var body) async {
    final response = await _apiService.postChat(endpoint: '/message', body: body);

    return response;
  }

  Future<dynamic> putLastMessage({var body, required String chatId}) async {
    final response = await _apiService.putChat(endpoint: '/chat/$chatId', body: body);

    return response;
  }
}
