
import 'package:get/get.dart';
import 'package:MeetingYuk/features/home/view_model/home_viewmodel.dart';
import 'package:MeetingYuk/features/home/view_model/search_viewmodel.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeViewModel>(HomeViewModel());
    Get.put<SearchViewModel>(SearchViewModel());

  }
}