import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';

class SentMessageWidget extends StatelessWidget {
  final String message;
  final String messageTime;

  const SentMessageWidget({required this.message, required this.messageTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper2(type: BubbleType.sendBubble),
      backGroundColor: ColorConstants.messageSentBgColor,
      margin: const EdgeInsets.only(left: 80, right: 10, top: 20),
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            message,
            style: const TextStyle(fontSize: 15, color: ColorConstants.textColor8),
          ),
          const SizedBox(height: 5),
          Text(
            messageTime.isEmpty
                ? sl<CommonFunctions>().getSentMessageTime()
                : sl<CommonFunctions>().getMessageTime(messageTime),
            style: const TextStyle(fontSize: 11, color: ColorConstants.textColor5),
          )
        ]),
      ),
    );
  }
}
