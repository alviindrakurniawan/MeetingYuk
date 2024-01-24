import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';


class TextInputField extends StatefulWidget {
  final String receiverId;
  final String chatId;
  final String roomKey;
  const TextInputField({
    super.key,
    required this.receiverId,
    required this.chatId,
    required this.roomKey,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  final ChatViewModel ctrl = Get.find();
  Color sendButtonColor = Colors.grey;

  // --------------------------------------------------------------
  // Function to send message, called when send button is pushed
  // --------------------------------------------------------------
  void sendTextMessage() async {
    if (isShowSendButton) {
      if (_messageController.text.trim() != '') {
        ctrl.sendTextMessage(
          chatId: widget.chatId,
          text: _messageController.text.trim(),
          receiverId: widget.receiverId,
          roomKey: widget.roomKey,
        );
        setState(() {
          _messageController.text = '';
        });
      } else {
        Get.defaultDialog(
            title: 'ERROR', content: const Text('message cannot be empty!'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        if (val.isNotEmpty) {
          setState(() {
            sendButtonColor = primaryColor;
            isShowSendButton = true;
          });
        } else {
          setState(() {
            sendButtonColor = Colors.grey;
            isShowSendButton = false;
          });
        }
      },
      controller: _messageController,
      keyboardType: TextInputType.multiline,
      autocorrect: false,
      decoration: InputDecoration(
        border: InputBorder.none,
        // constraints: const BoxConstraints.expand(height: 90),
        contentPadding: const EdgeInsets.only(
          top: 25,
          left: 24,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Tulis Pesan Anda...',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        suffixIcon: GestureDetector(
          // --------------------------------------------------------------
          // Call sendTextMessage function when pressed
          // --------------------------------------------------------------
          onTap: sendTextMessage,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
              color: sendButtonColor,
            ),
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
