
import 'package:get/get.dart';
import 'package:MeetingYuk/features/profile/view_model/profile_viewmodel.dart';
import 'package:MeetingYuk/features_merchantyuk/home_merchant/view_model/booking_merchantVM.dart';
import 'package:MeetingYuk/features_merchantyuk/home_merchant/view_model/dashboard_merchantVM.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/view_model/place_viewmodel.dart';

class DashMerchantBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<DashViewModel>(DashViewModel(), permanent: true);
    Get.put<DashMerchantViewModel>(DashMerchantViewModel());
    Get.put<ProfileViewModel>(ProfileViewModel());
    // Get.put<PlaceViewModel>(PlaceViewModel());
    // Get.put<BookingViewModel>(BookingViewModel());
    // Get.put<ChatViewModel>(ChatViewModel());
    // Get.lazyPut(() => ProfileViewModel(),fenix: true);
  }
}