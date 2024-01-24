import 'package:get/get.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';


class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatViewModel>(ChatViewModel());
  }
}