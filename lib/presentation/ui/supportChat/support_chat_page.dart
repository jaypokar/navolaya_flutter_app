import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/supportChatsBloc/support_chat_bloc.dart';

import '../../../data/model/chat_messages_model.dart';
import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/no_data_widget.dart';
import '../chatDetail/widgets/received_message_widget.dart';
import '../chatDetail/widgets/sent_message_widget.dart';
import 'widgets/support_chat_input_widget.dart';

class SupportChatPage extends StatefulWidget {
  const SupportChatPage({Key? key}) : super(key: key);

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  String image = ImageResources.appIcon;
  String userName = '';
  final ScrollController _scrollController = ScrollController();

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<SupportChatBloc>().isListFetchingComplete) {
          _loadInitialMessages();
        }
      }
    });
  }

  void _loadInitialMessages() {
    context.read<SupportChatBloc>().add(const GetSupportChatMessagesEvent());
  }

  void initializeList() {
    _loadInitialMessages();
    setupScrollController();
  }

  @override
  void initState() {
    super.initState();
    context.read<SupportChatBloc>().add(const CreateSupportChatEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupportChatBloc, SupportChatState>(
      listener: (_, state) {
        if (state is SupportChatMessagesErrorState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        } else if (state is SupportChatCreateState) {
          initializeList();
        }
      },
      child: BlocBuilder<SupportChatBloc, SupportChatState>(
        buildWhen: (_, state) {
          if (state is SupportChatCreateState || state is SupportChatInitial) {
            return true;
          }
          return false;
        },
        builder: (_, state) {
          if (state is SupportChatInitial) {
            return Container(
              color: Colors.white,
              child: const ImageLoaderWidget(),
            );
          } else if (state is SupportChatCreateState) {
            final chatDetails = state.response.data;
            final userImage = chatDetails!.user!.userImage;
            if (userImage != null) {
              if (userImage.thumburl != null) {
                image = userImage.thumburl!;
              }
            }

            userName = chatDetails.user!.fullName!;
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                centerTitle: false,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
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
                                errorWidget: (_, __, ___) =>
                                    Image.asset(ImageResources.userAvatarImg),
                                progressIndicatorBuilder: (_, __, ___) => const ImageLoaderWidget())
                            : Container(
                                padding: const EdgeInsets.only(top: 2),
                                color: Colors.white,
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
                      minFontSize: 13,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<SupportChatBloc, SupportChatState>(builder: (_, state) {
                      if (state is SupportChatMessagesLoadingState && state.isFirstFetch) {
                        return const ImageLoaderWidget();
                      }
                      late final List<ChatMessages> messages;
                      bool isLoading = false;
                      if (state is SupportChatMessagesLoadingState) {
                        //messages = List.from(state.oldMessages.reversed);
                        messages = state.oldMessages;
                        isLoading = true;
                      } else if (state is LoadSupportChatMessagesState) {
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
                  const SupportChatInputWidget()
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
