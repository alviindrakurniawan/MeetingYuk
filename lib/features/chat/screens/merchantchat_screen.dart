import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';
import 'package:MeetingYuk/features/profile/view_model/profile_viewmodel.dart';


// --------------------------------------------------------------
// Home Screen for Merchant
// --------------------------------------------------------------
class MerchantChatScreen extends GetView<ChatViewModel> {
  const MerchantChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<ChatViewModel>(ChatViewModel());
    final ProfileViewModel ctrl = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        toolbarHeight: 60.0,
        elevation: 0,
        title: Text('Chat', style: extraBoldBlack24),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Obx(
          () => controller.chatRoomList.length.toString() == '0'
              ? const Center(child: Text('You Have No Chat Data'))
              : ListView.builder(
                  itemCount: controller.chatRoomList.length,
                  itemBuilder: ((context, index) {
                    var chatContactData = controller.chatRoomList[index];

                    final recipientUser = chatContactData.users.firstWhere(
                      (user) =>
                          user.userId !=
                          ctrl.currentUser.value.userId,
                    );
                    final currentUser = chatContactData.users.firstWhere(
                      (user) =>
                          user.userId ==
                          ctrl.currentUser.value.userId,
                    );
                    DateTime timesent =
                        DateTime.parse(chatContactData.timesent);
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectChat(
                              controller.chatRoomList[index].chatId,
                              recipientUser.userId,
                              recipientUser.name,
                              recipientUser.profilePic,
                              currentUser.roomKey,
                            );
                            Get.toNamed('/detail-chat');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              leading: SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(recipientUser.profilePic),
                                ),
                              ),
                              title: Text(
                                recipientUser.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.0,
                                ),
                              ),
                              subtitle: Text(
                                chatContactData.lastMessage,
                                style: const TextStyle(
                                  // color: fontColor,
                                  // fontWeight: fontWeight,
                                  fontSize: 14.0,
                                ),
                              ),
                              trailing: Text(
                                DateFormat('Hm').format(timesent),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.sms,
          size: 32.0,
        ),
        onPressed: () {
          Get.toNamed('/broadcast');
        },
      )
    );
  }
}
