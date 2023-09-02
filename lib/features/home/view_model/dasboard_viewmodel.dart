
import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/view_model/explore_viewmodel.dart';
import 'package:meetingyuk/features/history/view_model/history_viewmodel.dart';
import 'package:meetingyuk/features/home/view_model/home_viewmodel.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';



class DashViewModel extends GetxController {

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
          Get.delete<HomeViewModel>();
          break;
        case 1:
          Get.delete<ExploreViewModel>();
          break;
        case 2:
          Get.delete<HistoryViewModel>();
          break;
        case 3:
          // print('waw');
          Get.delete<ProfileViewModel>();
          break;
      }
      _currentTab = currenttab;
      switch (_currentTab) {
        case 0:
          Get.put(HomeViewModel());
          break;
        case 1:
          Get.put(ExploreViewModel());
          break;
        case 2:
          Get.put(HistoryViewModel());
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
