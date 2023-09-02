import 'dart:ui';
import 'package:meetingyuk/network/api_service_http.dart';
import 'package:meetingyuk/network/network_api_services.dart';
import 'package:meetingyuk/ulits/app_url.dart';


class ProfileRepository {
  final ApiService _apiService = ApiService();

  Future<dynamic> getDetailProfile() async {
    final response = await _apiService.get(
      endpoint: '/profiles',
    );

    return response;
  }

  Future<dynamic> updateProfileImage(var body) async {
    final response = await _apiService.put(
      endpoint: '/profiles/images',
      body: body,
    );

    return response;
  }
  Future<dynamic> updateProfile(var body) async {
    final response = await _apiService.put(
      endpoint: '/profiles',
      body: body,
    );

    return response;
  }

  Future<dynamic> logout() async {
    final response = await _apiService.post(
      endpoint: '/auth/logout',
    );
    return response;
  }

  Future<dynamic> upgradeMerchant() async {
    final response = await _apiService.put(
      endpoint: '/profiles/merchants',
    );

    return response;
  }




}
