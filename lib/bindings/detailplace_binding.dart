import 'package:get/get.dart';
import 'package:MeetingYuk/features/auth/view_model/auth_viewmodel.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';
import 'package:MeetingYuk/features/home/view_model/reservation_viewmodel.dart';



class DetailPlaceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ReservationViewModel>(ReservationViewModel());
    // Get.put(ChatViewModel());
    Get.lazyPut(() => ChatViewModel());

  }
}