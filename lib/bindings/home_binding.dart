
import 'package:get/get.dart';
import 'package:meetingyuk/features/home/view_model/home_viewmodel.dart';
import 'package:meetingyuk/features/home/view_model/search_viewmodel.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeViewModel>(HomeViewModel());
    Get.put<SearchViewModel>(SearchViewModel());

  }
}