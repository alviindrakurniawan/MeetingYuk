
import 'package:get/get.dart';
import 'package:MeetingYuk/features/history/view_model/detailhistory_viewmodel.dart';


class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailHistoryViewModel());
  }
}



