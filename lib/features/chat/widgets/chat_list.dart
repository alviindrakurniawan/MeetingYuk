import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:MeetingYuk/common/ulits/aes_encryption.dart';
import 'package:MeetingYuk/features/auth/view_model/auth_viewmodel.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';
import 'package:MeetingYuk/features/chat/widgets/receipient_message_bubble.dart';
import 'package:MeetingYuk/features/chat/widgets/sender_message_bubble.dart';
import 'package:MeetingYuk/features/profile/view_model/profile_viewmodel.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    E2EE_AES aes = E2EE_AES();
    // --------------------------------------------------------------
    // Call "AuthController" and "ChatController"
    // --------------------------------------------------------------
    final ProfileViewModel authController = Get.find();
    final ChatViewModel ctrl = Get.find();

    // final ScrollController messageController = ScrollController();
    return Obx(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // messageController.jumpTo(messageController.position.maxScrollExtent);
      });
      return ListView.builder(
        // controller: messageController,
        itemCount: ctrl.messageList.length,
        itemBuilder: (context, index) {
          final messageData = ctrl.messageList[index];
          DateTime timesent = DateTime.parse(messageData.timesent);
          final decryptedText = aes.decrypter(ctrl.selectedRoom.value.roomKey,
              messageData.iv, messageData.message);
          if (messageData.senderId ==
              authController.currentUser.value.userId) {
            return SenderMessageBubble(
              message: decryptedText,
              time: DateFormat('HH:mm').format(timesent),
              type: messageData.type,
            );
          }
          return RecipientMessageBubble(
            message: decryptedText,
            time: DateFormat('HH:mm').format(timesent),
            type: messageData.type,
          );
        },
      );
    });
  }
}
