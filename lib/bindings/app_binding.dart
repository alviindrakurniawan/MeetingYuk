import 'package:get/get.dart';
import 'package:meetingyuk/network/getconnect_cookie.dart';
import 'package:meetingyuk/network/network_api_services.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetConnected(), permanent: true);
    Get.put(ApiService(), permanent: true);
  }
}