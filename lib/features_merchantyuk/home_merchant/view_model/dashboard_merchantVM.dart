import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/view_model/explore_viewmodel.dart';
import 'package:meetingyuk/features/history/view_model/history_viewmodel.dart';
import 'package:meetingyuk/features/home/view_model/home_viewmodel.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/view_model/booking_merchantVM.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/place_viewmodel.dart';



class DashMerchantViewModel extends GetxController {

  @override
  var _currentTab = 0;


  get currentTab => _currentTab;

  void changeScreen(int currenttab) {
    _currentTab = currenttab;
    update();
  }

  void changeScreen2(int currenttab) {
    if (currenttab != _currentTab) {
      switch (_currentTab) {
        case 0:
          Get.delete<BookingViewModel>();
          break;
        case 1:
          Get.delete<ExploreViewModel>();
          break;
        case 2:
          Get.delete<PlaceViewModel>();
          break;
        case 3:
          Get.delete<ProfileViewModel>();
          break;
      }
      _currentTab = currenttab;
      switch (_currentTab) {
        case 0:
          Get.put(BookingViewModel());
          break;
        case 1:
          Get.put(ExploreViewModel());
          break;
        case 2:
          Get.put(PlaceViewModel());
          break;
        case 3:
          Get.put(ProfileViewModel());
          break;
      }
      update();
    }
  }

// void changeScreen3(int index) {
//   pageController.jumpToPage(index);
// }

}