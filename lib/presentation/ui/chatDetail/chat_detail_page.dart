import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/chat_messages_model.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/chatMessagesBloc/chat_messages_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/chatDetail/widgets/chat_input_widget.dart';
import 'package:navolaya_flutter/presentation/ui/chatDetail/widgets/received_message_widget.dart';
import 'package:navolaya_flutter/presentation/ui/chatDetail/widgets/sent_message_widget.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../basicWidget/no_data_widget.dart';
import '../../cubit/socketConnectionCubit/socket_connection_cubit.dart';

class ChatDetailPage extends StatefulWidget {
  final ChatDetailsModel chatDetails;
  final int chatStatus;

  const ChatDetailPage({required this.chatDetails, required this.chatStatus, Key? key})
      : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String image = ImageResources.userAvatarImg;
  late final String userName;
  final ScrollController _scrollController = ScrollController();

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<ChatMessagesBloc>().isListFetchingComplete) {
          _loadInitialMessages();
        }
      }
    });
  }

  void _loadInitialMessages() {
    context.read<ChatMessagesBloc>().add(GetMessagesEvent(chatID: widget.chatDetails.id!));
  }

  @override
  void initState() {
    super.initState();

    final userImage = widget.chatDetails.user!.userImage;
    if (userImage != null) {
      final userImageFilePath = widget.chatDetails.user!.userImage!.thumburl;
      final displaySettings = widget.chatDetails.user!.displayImageSettings;
      final isUserConnected = widget.chatDetails.user!.isConnected;
      if (displaySettings!.showImageTo! == 'all' ||
          (displaySettings.showImageTo == 'my_connections' && isUserConnected!)) {
        if (userImageFilePath!.contains('http')) {
          image = userImageFilePath;
        }
      }
    }

    userName = widget.chatDetails.user!.fullName!;

    setupScrollController();
    _loadInitialMessages();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatMessagesBloc, ChatMessagesState>(listener: (_, state) {
          if (state is ChatMessagesErrorState) {
            sl<CommonFunctions>().showFlushBar(
              context: context,
              message: state.message,
              bgColor: ColorConstants.messageErrorBgColor,
            );
          }
        }),
        BlocListener<SocketConnectionCubit, SocketConnectionState>(listener: (_, state) {
          if (state is LoadReceivedMessageState) {
            if (widget.chatDetails.id! == state.chatAndMessageInfo.chat!.id!) {
              context.read<ChatMessagesBloc>().add(
                  HandleReceivedMessagesEvent(message: state.chatAndMessageInfo.chatMessages!));
            }
          }
        })
      ],
      child: WillPopScope(
        onWillPop: () {
          navigateBackToChatScreen();
          return Future(() => true);
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: false,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                navigateBackToChatScreen();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image.contains('http')
                        ? CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => Image.asset(ImageResources.userAvatarImg),
                            progressIndicatorBuilder: (_, __, ___) => const ImageLoaderWidget())
                        : Container(
                            padding: const EdgeInsets.only(top: 2),
                            color: Colors.white.withOpacity(0.6),
                            child: Image.asset(
                              image,
                            )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                AutoSizeText(
                  userName,
                  softWrap: true,
                  minFontSize: 16,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatMessagesBloc, ChatMessagesState>(builder: (_, state) {
                  if (state is ChatMessagesLoadingState && state.isFirstFetch) {
                    return const ImageLoaderWidget();
                  }
                  late final List<ChatMessages> messages;
                  bool isLoading = false;
                  if (state is ChatMessagesLoadingState) {
                    //messages = List.from(state.oldMessages.reversed);
                    messages = state.oldMessages;
                    isLoading = true;
                  } else if (state is LoadChatMessagesState) {
                    messages = state.messages;
                  } else {
                    messages = [];
                  }

                  if (messages.isEmpty && !isLoading) {
                    return const NoDataWidget(
                      message: StringResources.noDataAvailableMessage,
                      icon: ImageResources.chatIcon,
                    );
                  }
                  return ListView.builder(
                    itemCount: messages.length + (isLoading ? 1 : 0),
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 5),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      if (index < messages.length) {
                        if (messages[index].direction! == 'right') {
                          return SentMessageWidget(
                            message: messages[index].messageText!,
                            messageTime: messages[index].messageTime!,
                          );
                        }
                        return ReceivedMessageWidget(
                            message: messages[index].messageText!,
                            messageTime: messages[index].messageTime!);
                      } else {
                        Timer(const Duration(milliseconds: 30), () {
                          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                        });

                        return const ImageLoaderWidget();
                      }
                    },
                  );
                }),
              ),
              widget.chatStatus == 1
                  ? ChatInputWidget(
                      chatID: widget.chatDetails.id!, userID: widget.chatDetails.user!.id!)
                  : Container(
                      margin: const EdgeInsets.all(30),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0 / 2,
                      ),
                      child: const Text(
                        StringResources.cantSendMessage,
                        style: TextStyle(color: ColorConstants.textColor2, fontSize: 15),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void navigateBackToChatScreen() {
    final resultBack = context.read<ChatMessagesBloc>().hasChatInitiated
        ? {
            ValueKeyResources.chatIdKey: widget.chatDetails.id,
            ValueKeyResources.chatLastMessageKey: context.read<ChatMessagesBloc>().getLastMessage(),
            ValueKeyResources.chatMessageTimeKey:
                context.read<ChatMessagesBloc>().getLastMessageTime(),
          }
        : null;
    Navigator.of(context).pop(resultBack);
  }
}
