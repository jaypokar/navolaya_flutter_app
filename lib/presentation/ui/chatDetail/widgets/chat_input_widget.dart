import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/chatMessagesBloc/chat_messages_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/socketConnectionCubit/socket_connection_cubit.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class ChatInputWidget extends StatelessWidget {
  final String chatID;
  final String userID;

  const ChatInputWidget({required this.chatID, required this.userID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0 / 2,
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20 * 0.75,
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstants.appColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.grey.withOpacity(0.2))),
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(color: ColorConstants.textColor3, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: StringResources.enterMessage,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                if (textController.text.isEmpty) return;
                context
                    .read<SocketConnectionCubit>()
                    .sendChatMessage(chatID, userID, textController.text);
                context.read<ChatMessagesBloc>().add(SendMessageEvent(
                    chatID: chatID, chatUserID: userID, message: textController.text));
                textController.clear();
              },
              child: Container(
                height: 46,
                width: 46,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: ColorConstants.appColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  ImageResources.sendIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
