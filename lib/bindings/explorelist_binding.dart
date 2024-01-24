import 'package:get/get.dart';
import 'package:MeetingYuk/features/explore/view_model/explorelist_viewmodel.dart';



class ListExploreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListExploreViewModel(),fenix : true);
    // Get.put<ListExploreViewModel>(ListExploreViewModel());
  }
}