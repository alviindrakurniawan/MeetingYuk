import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/enums/message_enum.dart';

class DisplayMessage extends StatelessWidget {
  final String message;
  final MessageEnum type;
  final bool isSender;

  const DisplayMessage({
    super.key,
    required this.message,
    required this.type,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        fontSize: 16,
        color: isSender != true ? Colors.white : Colors.black,
      ),
    );
  }
}
