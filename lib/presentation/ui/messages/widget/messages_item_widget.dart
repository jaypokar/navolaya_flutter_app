import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';
import 'package:navolaya_flutter/presentation/cubit/getChatsCubit/get_chats_cubit.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../../../core/route_generator.dart';
import '../../../../data/model/chat_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/value_key_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/image_loader_widget.dart';

class MessagesItemWidget extends StatelessWidget {
  final Chat chat;

  const MessagesItemWidget({required this.chat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = ImageResources.userAvatarImg;

    String name = "";
    String message = "";
    if (chat.user != null) {
      name = chat.user!.fullName!;
      message = chat.lastMessage!;
      if (chat.user!.userImage != null) {
        final userImageFilePath = chat.user!.userImage!.thumburl;
        final displaySettings = chat.user!.displayImageSettings;
        final isUserConnected = chat.user!.isConnected;

        if ((displaySettings!.showImageTo! == 'all' ||
            (displaySettings.showImageTo! == 'my_connections' && isUserConnected!))) {
          if (userImageFilePath!.contains('http')) {
            image = userImageFilePath;
          }
        }
      }
    }
    final chatsCubit = context.read<GetChatsCubit>();
    return InkWell(
      onTap: () async {
        final chatDetails = ChatDetailsModel(id: chat.id!, user: chat.user);
        final result = await Navigator.of(context).pushNamed(RouteGenerator.chatDetailPage,
            arguments: {
              ValueKeyResources.chatDetailDataKey: chatDetails,
              ValueKeyResources.chatStatusKey: chat.chatStatus!
            }) as Map<String, dynamic>?;
        if (result != null) {
          logger.i(result);
          chat.lastMessage = result[ValueKeyResources.chatLastMessageKey];
          chat.lastMessageTime = result[ValueKeyResources.chatMessageTimeKey];
          chatsCubit.updateChatPosition(chat);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: ColorConstants.appColor.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: image.contains('http')
                    ? CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Image.asset(ImageResources.userAvatarImg),
                        progressIndicatorBuilder: (_, __, ___) => const ImageLoaderWidget())
                    : Image.asset(image),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    name,
                    minFontSize: 15,
                    maxLines: 1,
                    softWrap: true,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.checkDouble,
                        color: ColorConstants.textColor3,
                        size: 12,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ColorConstants.textColor3,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              height: 40,
              child: Container(
                height: 10,
                alignment: Alignment.topRight,
                child: Text(
                  sl<CommonFunctions>().getMessageTime(chat.lastMessageTime!),
                  style: const TextStyle(
                    color: ColorConstants.textColor5,
                    fontSize: 10,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
