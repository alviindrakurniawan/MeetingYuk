import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';
import 'package:MeetingYuk/features/profile/view_model/profile_viewmodel.dart';
import 'package:MeetingYuk/features/profile/widgets/button.dart';

class BroadcastScreen extends StatefulWidget {
  static const String routeName = '/broadcast-screen';
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  // --------------------------------------------------------------
  // Define local variables
  // --------------------------------------------------------------
  List selectedReceiver = [];
  List selectedChat = [];
  List selectedKey = [];
  final TextEditingController _messageController = TextEditingController();

  // --------------------------------------------------------------
  // Call "AuthController" and "ChatController"
  // --------------------------------------------------------------
  final ProfileViewModel ctrl = Get.find();
  final ChatViewModel controller = Get.find();

  // --------------------------------------------------------------
  // Function to select broadcast user receivers
  // --------------------------------------------------------------
  void onReceiverSelected(bool selected, chatId, receiverId, roomKey) {
    if (selected == true) {
      setState(() {
        selectedReceiver.add(receiverId);
        selectedChat.add(chatId);
        selectedKey.add(roomKey);
      });
    } else {
      setState(() {
        selectedReceiver.remove(receiverId);
        selectedChat.remove(chatId);
        selectedKey.remove(roomKey);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        titleSpacing: 0,
        toolbarHeight: 60.0,
        elevation: 0,
        title: Text('Broadcast', style: extraBoldBlack24),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: blackColor),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pesan Broadcast',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                decoration: const InputDecoration(
                    hintText: 'Masukkan pesan broadcast...'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Text('Pilih tujuan pesan:'),

              // --------------------------------------------------------------
              // Widget to view list of receivers
              // --------------------------------------------------------------
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.chatRoomList.length,
                itemBuilder: (context, index) {
                  final recipientUser =
                      controller.chatRoomList[index].users.firstWhere(
                    (user) =>
                        user.userId !=
                        ctrl.currentUser.value.userId,
                  );
                  final currentUser =
                      controller.chatRoomList[index].users.firstWhere(
                    (user) =>
                        user.userId ==
                        ctrl.currentUser.value.userId,
                  );
                  return ListTile(
                    title: Text(recipientUser.name),
                    trailing: Checkbox(
                      value: selectedChat
                          .contains(controller.chatRoomList[index].chatId),
                      onChanged: (val) {
                        onReceiverSelected(
                            val!,
                            controller.chatRoomList[index].chatId,
                            recipientUser.userId,
                            currentUser.roomKey);
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: CustomFilledButton(
                    title: Text('KIRIM',style: boldBlack16,),
                    onPressed: () {
                      // --------------------------------------------------------------
                      // Call this when button is pressed
                      // --------------------------------------------------------------
                      if (_messageController.text == '' ||
                          selectedChat.isEmpty) {
                        Get.defaultDialog(
                          title: 'Gagal',
                          content: const Text(
                              'Silakan isi teks pesan dan pilih tujuan pesan'),
                        );
                      } else {
                        controller.sendBroadcastMessage(
                            text: _messageController.text,
                            chatId: selectedChat,
                            receiverId: selectedReceiver,
                            roomKey: selectedKey);
                        Get.back();
                        Get.defaultDialog(
                          title: 'Success',
                          content:
                              const Text('Pesan Broadcast Berhasil Dikirim!'),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
