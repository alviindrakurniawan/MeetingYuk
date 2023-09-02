
import 'package:get/get.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ProfileViewModel(), fenix: true);

    Get.put<ProfileViewModel>(ProfileViewModel());
  }
}