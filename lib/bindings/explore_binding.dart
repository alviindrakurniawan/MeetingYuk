import 'package:get/get.dart';
import 'package:MeetingYuk/features/explore/view_model/explore_viewmodel.dart';



class ExploreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreViewModel());
  }
}