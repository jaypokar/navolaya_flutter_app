import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/loading_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/createChatBloc/create_chat_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/reportUsersCubit/report_users_cubit.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../data/sessionManager/session_manager.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/text_field_widget.dart';

enum ConnectionType { connect, pending, respond }

enum ConnectionRespondType { accept, cancel, none }

enum UserMoreOptionType { report, block, unFriend, cancel }

class UserConnectMessageAndOptionWidget extends StatefulWidget {
  final UserDataModel user;

  const UserConnectMessageAndOptionWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<UserConnectMessageAndOptionWidget> createState() =>
      _UserConnectMessageAndOptionWidgetState();
}

class _UserConnectMessageAndOptionWidgetState extends State<UserConnectMessageAndOptionWidget> {
  String _connectOrPending = '';
  bool showMessageView = true;
  bool _isJnvStatusVerified = true;

  @override
  void initState() {
    super.initState();
    checkRequestStatus();
    checkShowMessageButton();
    _isJnvStatusVerified = sl<SessionManager>().getUserDetails()!.data!.jnvVerificationStatus! == 1;
  }

  void checkShowMessageButton() {
    showMessageView = widget.user.displaySettings!.sendMessage! == 'all' ||
        (widget.user.displaySettings!.sendMessage! == 'my_connections' && widget.user.isConnected!);
  }

  void checkRequestStatus() {
    if (widget.user.isConnected != null) {
      if (!widget.user.isConnected!) {
        _connectOrPending = StringResources.connect;
      }
    }
    if (widget.user.isRequestSent != null) {
      if (widget.user.isRequestSent!) {
        _connectOrPending = StringResources.pending;
      }
    }
    if (widget.user.isRequestReceived != null) {
      if (widget.user.isRequestReceived! && !widget.user.isConnected!) {
        _connectOrPending = StringResources.accept;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<UserConnectionsBloc, UserConnectionsState>(
        buildWhen: (_, state) {
          if (state is GetConnectionsState || state is UserConnectionLoadingState) {
            return false;
          }
          return true;
        },
        builder: (_, state) {
          if (state is CreateConnectionsState) {
            _connectOrPending = StringResources.pending;
          } else if (state is UpdateConnectionsState) {
            _connectOrPending = state.isRequestAccepted ? '' : StringResources.connect;
            showMessageView = widget.user.displaySettings!.sendMessage! == 'all' ||
                (widget.user.displaySettings!.sendMessage! == 'my_connections' &&
                    state.isRequestAccepted);
          } else if (state is RemoveConnectionsState) {
            _connectOrPending = StringResources.connect;
          }

          return Row(
            children: [
              manageConnectButton(),
              messageButton(),
              const SizedBox(width: 10),
              InkWell(
                onTap: _isJnvStatusVerified ? () => showMoreOptionsBottomSheet() : null,
                child: Container(
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      color: _isJnvStatusVerified ? Colors.black : ColorConstants.messageBgColor,
                    )),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget messageButton() {
    return BlocBuilder<CreateChatBloc, CreateChatState>(
      builder: (_, state) {
        return Expanded(
          child: OutlinedButton(
            onPressed: (!showMessageView && !_isJnvStatusVerified)
                ? null
                : () => context.read<CreateChatBloc>().add(
                      InitiateChatEvent(userID: widget.user.id!),
                    ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: BorderSide(
                width: 1.0,
                color: state == const CreateChatLoadingState()
                    ? ColorConstants.messageBgColor
                    : (showMessageView && _isJnvStatusVerified)
                        ? ColorConstants.appColor
                        : ColorConstants.greyColor,
              ),
            ),
            child: Text(
              state == const CreateChatLoadingState()
                  ? StringResources.loading
                  : StringResources.message.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: state == const CreateChatLoadingState()
                      ? ColorConstants.messageBgColor
                      : (showMessageView && _isJnvStatusVerified)
                          ? ColorConstants.appColor
                          : ColorConstants.greyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  Widget manageConnectButton() {
    logger.i('the connection status is :$_connectOrPending');
    if (_connectOrPending == StringResources.connect ||
        _connectOrPending == StringResources.accept) {
      return connectOrAcceptButton();
    } else if (_connectOrPending == StringResources.pending || _connectOrPending == '') {
      return pendingOrConnectedButton();
    }
    return const SizedBox.shrink();
  }

  Widget connectOrAcceptButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: BlocBuilder<UserConnectionsBloc, UserConnectionsState>(
          builder: (_, state) {
            logger.i('the state is $state');

            return ElevatedButton(
              onPressed: _isJnvStatusVerified
                  ? () {
                      logger.i('the connection status is :$_connectOrPending');
                      if (_connectOrPending == StringResources.connect) {
                        context
                            .read<UserConnectionsBloc>()
                            .add(CreateConnectionsEvent(userID: widget.user.id!));
                      } else if (_connectOrPending == StringResources.accept) {
                        context.read<UserConnectionsBloc>().add(UpdateConnectionRequestEvent(
                            userID: widget.user.id!,
                            acceptOrCancel: 'accept',
                            isRequestAccepted: true));
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(42),
                  onPrimary: Colors.white,
                  primary: state == const UserConnectionLoadingState()
                      ? ColorConstants.messageBgColor
                      : ColorConstants.appColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              child: Text(
                state == const UserConnectionLoadingState()
                    ? StringResources.loading
                    : _connectOrPending.toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget pendingOrConnectedButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: BlocBuilder<UserConnectionsBloc, UserConnectionsState>(
          builder: (_, state) {
            String title = '';
            Color color;
            if (state is UserConnectionLoadingState) {
              title = StringResources.loading;
              color = ColorConstants.messageBgColor;
            } else if (_connectOrPending.isEmpty) {
              title = StringResources.connected;
              color = ColorConstants.appColor.withOpacity(0.4);
            } else {
              title = StringResources.pending;
              color = ColorConstants.greyColor;
            }

            return OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                side: BorderSide(
                  width: 1.0,
                  color: color,
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showMoreOptionsBottomSheet() async {
    UserMoreOptionType? respondType = await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return UserMoreOptionsWidget(
            isConnected: _connectOrPending.isEmpty,
            connectionStatus: _connectOrPending,
          );
        });

    if (!mounted) return;
    if (respondType != null) {
      if (respondType == UserMoreOptionType.unFriend) {
        context.read<UserConnectionsBloc>().add(RemoveConnectionEvent(userID: widget.user.id!));
      } else if (respondType == UserMoreOptionType.cancel) {
        context.read<UserConnectionsBloc>().add(UpdateConnectionRequestEvent(
            userID: widget.user.id!, acceptOrCancel: 'cancel', isRequestAccepted: false));
      } else if (respondType == UserMoreOptionType.block) {
        showBlockUserDialog();
      } else if (respondType == UserMoreOptionType.report) {
        showReportUserDialog();
      }
    }
  }

  void showBlockUserDialog() async {
    if (!mounted) return;
    final blocUserCubit = context.read<BlockUsersCubit>();
    showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return BlocProvider<BlockUsersCubit>.value(
          value: blocUserCubit,
          child: BlockUserDialogWidget(
            userID: widget.user.id!,
          ),
        );
      },
    );
  }

  void showReportUserDialog() async {
    if (!mounted) return;
    final reportUserCubit = context.read<ReportUsersCubit>();
    showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return BlocProvider<ReportUsersCubit>.value(
          value: reportUserCubit,
          child: ReportUserDialogWidget(
            userID: widget.user.id!,
          ),
        );
      },
    );
  }
}

class UserMoreOptionsWidget extends StatelessWidget {
  final bool isConnected;
  final String connectionStatus;

  const UserMoreOptionsWidget({required this.isConnected, this.connectionStatus = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String connectionRespondTitle = '';
    if (connectionStatus == StringResources.accept || connectionStatus == StringResources.pending) {
      connectionRespondTitle = StringResources.cancelRequest;
    } else if (connectionStatus == '') {
      connectionRespondTitle = StringResources.unFriend;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (connectionRespondTitle.isNotEmpty) ...[
          ListTile(
            horizontalTitleGap: 0,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: const Icon(
              Icons.cancel,
              size: 30,
              color: ColorConstants.messageErrorBgColor,
            ),
            title: Text(
              connectionRespondTitle,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pop((connectionStatus == StringResources.accept ||
                      connectionStatus == StringResources.pending)
                  ? UserMoreOptionType.cancel
                  : UserMoreOptionType.unFriend);
            },
          ),
          const Divider(),
        ],
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.only(left: 18, bottom: 0),
          leading: const Icon(
            Icons.report,
            size: 30,
            color: ColorConstants.messageErrorBgColor,
          ),
          title: const Text(
            StringResources.reportUser,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(UserMoreOptionType.report);
          },
        ),
        const Divider(),
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.only(left: 18, bottom: 10),
          leading: const Icon(
            Icons.person_off,
            size: 30,
            color: ColorConstants.messageErrorBgColor,
          ),
          title: const Text(
            StringResources.blockUser,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(UserMoreOptionType.block);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class BlockUserDialogWidget extends StatelessWidget {
  final String userID;

  const BlockUserDialogWidget({required this.userID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SizedBox(
        height: 390,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                StringResources.blockUserTitle,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                StringResources.blockUserDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.textColor2,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: reasonController,
                hint: StringResources.reasonToBlock,
                textInputType: TextInputType.multiline,
                max: 1000,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (BuildContext parentContext) {
                  return BlocBuilder<BlockUsersCubit, BlockUsersState>(
                    builder: (_, state) {
                      if (state is BlockUserLoadingState) {
                        return const LoadingWidget();
                      }
                      return ButtonWidget(
                          buttonText: StringResources.blockUser.toUpperCase(),
                          padding: 0,
                          color: ColorConstants.messageErrorBgColor,
                          onPressButton: () {
                            if (reasonController.text.isEmpty) {
                              return;
                            }
                            context.read<BlockUsersCubit>().blockUser(
                                  userID: userID,
                                  reason: reasonController.text,
                                );
                          });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReportUserDialogWidget extends StatelessWidget {
  final String userID;

  const ReportUserDialogWidget({required this.userID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SizedBox(
        height: 390,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                StringResources.reasonUserTitle,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                StringResources.reportUserDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.textColor2,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: reasonController,
                hint: StringResources.reasonToReport,
                textInputType: TextInputType.multiline,
                max: 1000,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (BuildContext parentContext) {
                  return BlocBuilder<ReportUsersCubit, ReportUsersState>(
                    builder: (_, state) {
                      if (state is ReportUserLoadingState) {
                        return const LoadingWidget();
                      }
                      return ButtonWidget(
                          buttonText: StringResources.reportUser.toUpperCase(),
                          padding: 0,
                          color: ColorConstants.messageErrorBgColor,
                          onPressButton: () {
                            if (reasonController.text.isEmpty) {
                              return;
                            }
                            context.read<ReportUsersCubit>().reportUser(
                                  userID: userID,
                                  reason: reasonController.text,
                                );
                          });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
