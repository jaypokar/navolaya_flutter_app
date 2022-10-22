import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/socketConnectionCubit/socket_connection_cubit.dart';

import '../../../data/model/chat_model.dart';
import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/image_loader_widget.dart';
import '../../basicWidget/no_data_widget.dart';
import '../../cubit/getChatsCubit/get_chats_cubit.dart';
import 'widget/messages_item_widget.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadChats();
    setupScrollController();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<GetChatsCubit>().isListFetchingComplete) {
          context.read<GetChatsCubit>().loadChats();
        }
      }
    });
  }

  void _loadChats() {
    context.read<GetChatsCubit>().loadChats(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<GetChatsCubit, GetChatsState>(
            listener: (_, state) {
              if (state is ChatErrorState) {
                sl<CommonFunctions>().showFlushBar(
                  context: context,
                  message: state.message,
                  bgColor: ColorConstants.messageErrorBgColor,
                );
              }
            },
          ),
          BlocListener<SocketConnectionCubit, SocketConnectionState>(listener: (_, state) {
            if (state is LoadReceivedMessageState) {
              context.read<GetChatsCubit>().chatMessageReceived(state.chatAndMessageInfo);
            }
          })
        ],
        child: BlocBuilder<GetChatsCubit, GetChatsState>(
          builder: (_, state) {
            if (state is GetChatsLoadingState && state.isFirstFetch) {
              return const ImageLoaderWidget();
            }
            List<Chat> chats = [];
            bool isLoading = false;
            if (state is GetChatsLoadingState) {
              chats = state.oldChats;
              isLoading = true;
            } else if (state is LoadChatsState) {
              chats = state.chats;
            }

            if (chats.isEmpty && !isLoading) {
              return const NoDataWidget(
                message: StringResources.noDataAvailableMessage,
                icon: ImageResources.chatIcon,
              );
            }

            return ListView.separated(
              itemCount: chats.length + (isLoading ? 1 : 0),
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                if (index < chats.length) {
                  return index == chats.length - 1
                      ? Column(
                          children: [
                            MessagesItemWidget(
                              /*key: ValueKey(chats[index].id!),*/
                              chat: chats[index],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )
                      : MessagesItemWidget(
                          /*key: ValueKey(chats[index].id!),*/
                          chat: chats[index],
                        );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return const ImageLoaderWidget();
                }
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                );
              },
            );
          },
        ));
  }
}
