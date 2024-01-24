import 'package:get/get.dart';
import 'package:MeetingYuk/network/getconnect_cookie.dart';
import 'package:MeetingYuk/network/network_api_services.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetConnected(), permanent: true);
    Get.put(ApiService(), permanent: true);
  }
}