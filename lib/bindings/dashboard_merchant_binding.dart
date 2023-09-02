
import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/view_model/explore_viewmodel.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/screens/booking_merchant.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/view_model/booking_merchantVM.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/view_model/dashboard_merchantVM.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/place_viewmodel.dart';

class DashMerchantBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<DashViewModel>(DashViewModel(), permanent: true);
    Get.put<DashMerchantViewModel>(DashMerchantViewModel());
    Get.put<BookingViewModel>(BookingViewModel());
    Get.put<ExploreViewModel>(ExploreViewModel());
    Get.put<ProfileViewModel>(ProfileViewModel());
    Get.put<PlaceViewModel>(PlaceViewModel());
    // Get.lazyPut(() => ProfileViewModel(),fenix: true);
  }
}