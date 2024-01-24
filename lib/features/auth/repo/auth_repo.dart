import 'dart:ui';
import 'package:MeetingYuk/network/network_api_services.dart';



class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<dynamic> login(var body) async {
    final response = await _apiService.post(
      endpoint: '/auth/login',
      body: body,
    );
    
    return response;
  }

  Future<dynamic> register(var body) async {
    final response = await _apiService.post(
      endpoint: '/auth/register',
      body: body,
    );

    return response;
  }


  Future<dynamic> forgetPassword(var body) async {
    final response = await _apiService.post(
      endpoint: '/auth/forget-password',
      body: body,
    );

    return response;
  }

  Future resetPassword(body) async {
    final response = await _apiService.post(
      endpoint: '/auth/reset-password',
      body: body,
    );

    return response;
  }
}
