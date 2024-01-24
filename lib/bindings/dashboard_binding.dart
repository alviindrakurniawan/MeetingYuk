
import 'package:get/get.dart';
import 'package:MeetingYuk/features/home/view_model/dasboard_viewmodel.dart';
import 'package:MeetingYuk/features/profile/view_model/profile_viewmodel.dart';

class DashBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<DashViewModel>(DashViewModel(), permanent: true);
    Get.put<DashViewModel>(DashViewModel());
    // Get.put<ExploreViewModel>(ExploreViewModel());
    Get.put<ProfileViewModel>(ProfileViewModel());
    // Get.lazyPut(() => ProfileViewModel(),fenix: true);
  }
}