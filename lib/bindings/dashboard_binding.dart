
import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/view_model/explore_viewmodel.dart';
import 'package:meetingyuk/features/history/view_model/history_viewmodel.dart';
import 'package:meetingyuk/features/home/view_model/dasboard_viewmodel.dart';
import 'package:meetingyuk/features/home/view_model/home_viewmodel.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';

class DashBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<DashViewModel>(DashViewModel(), permanent: true);
    Get.put<DashViewModel>(DashViewModel());
    Get.put<HomeViewModel>(HomeViewModel());
    Get.put<ExploreViewModel>(ExploreViewModel());
    Get.put<ProfileViewModel>(ProfileViewModel());
    Get.put<HistoryViewModel>(HistoryViewModel());
    // Get.lazyPut(() => ProfileViewModel(),fenix: true);
  }
}