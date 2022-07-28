import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/loading_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/text_field_widget.dart';

enum ConnectionType { connect, pending, respond }

enum ConnectionRespondType { accept, cancel, none }

enum UserMoreOptionType { block, unFriend, cancel }

class UserConnectMessageAndOptionWidget extends StatefulWidget {
  final UserDataModel user;

  const UserConnectMessageAndOptionWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<UserConnectMessageAndOptionWidget> createState() =>
      _UserConnectMessageAndOptionWidgetState();
}

class _UserConnectMessageAndOptionWidgetState extends State<UserConnectMessageAndOptionWidget> {
  String connectOrPending = '';
  bool requestAccepted = true;

  @override
  void initState() {
    super.initState();
    checkRequestStatus();
  }

  void checkRequestStatus() {
    if (widget.user.isConnected != null) {
      if (!widget.user.isConnected!) {
        connectOrPending = StringResources.connect;
      }
    }
    if (widget.user.isRequestSent != null) {
      if (widget.user.isRequestSent!) {
        connectOrPending = StringResources.pending;
      }
    }
    if (widget.user.isRequestReceived != null) {
      if (widget.user.isRequestReceived!) {
        connectOrPending = StringResources.respond;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<UserConnectionsBloc, UserConnectionsState>(
          buildWhen: (_, state) {
            if (state is GetConnectionsState) {
              return false;
            }
            return true;
          },
          builder: (_, state) {
            if (state is UserConnectionLoadingState) {
              return const LoadingWidget();
            }
            if (state is CreateConnectionsState) {
              connectOrPending = StringResources.pending;
            } else if ((state is UpdateConnectionsState && !requestAccepted) ||
                state is RemoveConnectionsState) {
              connectOrPending = StringResources.connect;
            } else if (state is UpdateConnectionsState && requestAccepted) {
              connectOrPending = '';
            }

            return manageConnectButton();
          },
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: const BorderSide(
                width: 1.0,
                color: ColorConstants.appColor,
              ),
            ),
            child: const Text(
              StringResources.message,
              style: TextStyle(
                  color: ColorConstants.appColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => showMoreOptionsBottomSheet(),
          child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.more_horiz)),
        ),
      ],
    );
  }

  Widget manageConnectButton() {
    /*if (connectionStatus.isNotEmpty) {
      connectOrPending = connectionStatus;
    }*/
    logger.i('the connection status is :$connectOrPending');
    if (connectOrPending == StringResources.connect ||
        connectOrPending == StringResources.respond) {
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (connectOrPending == StringResources.connect) {
              context
                  .read<UserConnectionsBloc>()
                  .add(CreateConnectionsEvent(userID: widget.user.id!));
            } else if (connectOrPending == StringResources.respond) {
              showAcceptOrRejectBottomSheet();
            }
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            side: const BorderSide(width: 1.0, color: ColorConstants.appColor),
          ),
          child: Text(
            connectOrPending,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      );
    } else if (connectOrPending == StringResources.pending) {
      return Expanded(
        child: OutlinedButton(
          onPressed: () {
            //showAcceptOrRejectBottomSheet();
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            side: const BorderSide(
              width: 1.0,
              color: ColorConstants.greyColor,
            ),
          ),
          child: Text(
            connectOrPending,
            style: const TextStyle(
                color: ColorConstants.greyColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void showAcceptOrRejectBottomSheet() async {
    ConnectionRespondType respondType = await showModalBottomSheet(
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.23,
          ),
        ),
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return const ConnectionResponseWidget();
        });

    if (!mounted) return;
    if (respondType != ConnectionRespondType.none) {
      requestAccepted = respondType == ConnectionRespondType.accept;
      context.read<UserConnectionsBloc>().add(UpdateConnectionRequestEvent(
          userID: widget.user.id!,
          acceptOrCancel: respondType != ConnectionRespondType.accept ? 'accept' : 'cancel'));
    }
  }

  void showMoreOptionsBottomSheet() async {
    UserMoreOptionType respondType = await showModalBottomSheet(
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * (connectOrPending.isEmpty ? 0.33 : 0.20),
          ),
        ),
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
            isConnected: connectOrPending.isEmpty,
          );
        });

    if (!mounted) return;
    if (respondType == UserMoreOptionType.unFriend) {
      context.read<UserConnectionsBloc>().add(RemoveConnectionEvent(userID: widget.user.id!));
    } else if (respondType == UserMoreOptionType.block) {
      showBlockUserDialog(context);
    }
  }

  void showBlockUserDialog(BuildContext buildContext) async {
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
}

class ConnectionResponseWidget extends StatelessWidget {
  const ConnectionResponseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        ListTile(
          horizontalTitleGap: 20,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          leading: const Icon(
            Icons.person_add_rounded,
            size: 30,
            color: ColorConstants.appColor,
          ),
          title: const Text(
            StringResources.accept,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          onTap: () {
            Navigator.of(context).pop(ConnectionRespondType.accept);
          },
        ),
        const Divider(),
        ListTile(
          horizontalTitleGap: 20,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: const Icon(
            Icons.person_remove,
            size: 30,
            color: Colors.orange,
          ),
          title: const Text(
            StringResources.cancel,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          onTap: () {
            Navigator.of(context).pop(ConnectionRespondType.cancel);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class UserMoreOptionsWidget extends StatelessWidget {
  final bool isConnected;

  const UserMoreOptionsWidget({required this.isConnected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        ListTile(
          horizontalTitleGap: 20,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          leading: const Icon(
            Icons.person_off,
            size: 30,
            color: ColorConstants.red,
          ),
          title: const Text(
            StringResources.blockUser,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(UserMoreOptionType.block);
          },
        ),
        if (isConnected) ...[
          const Divider(),
          ListTile(
            horizontalTitleGap: 20,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: const Icon(
              Icons.person_remove,
              size: 30,
              color: Colors.orange,
            ),
            title: const Text(
              StringResources.unFriend,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pop(UserMoreOptionType.unFriend);
            },
          ),
        ],
        ButtonWidget(
            buttonText: StringResources.cancel,
            padding: 20,
            onPressButton: () => Navigator.of(context).pop(UserMoreOptionType.cancel))
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
        height: MediaQuery.of(context).size.height * 0.30,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: reasonController,
                hint: StringResources.reasonToBlock,
                textInputType: TextInputType.text,
                max: 1000,
                maxLines: 5,
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
