import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/user_circular_picture_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionReceivedCubit/connection_received_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionSentCubit/connection_sent_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/myConnectionsCubit/my_connections_cubit.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/logger.dart';
import '../../../../core/route_generator.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/value_key_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/loading_widget.dart';

enum ConnectionsType { myConnections, connectionsReceived, connectionsSent }

class MyConnectionsItemWidget extends StatefulWidget {
  final ConnectionsType connectionsType;
  final UserDataModel user;

  const MyConnectionsItemWidget({required this.user, required this.connectionsType, Key? key})
      : super(key: key);

  @override
  State<MyConnectionsItemWidget> createState() => _MyConnectionsItemWidgetState();
}

class _MyConnectionsItemWidgetState extends State<MyConnectionsItemWidget> {
  String image = ImageResources.userAvatarImg;
  late UserDataModel user;

  @override
  void initState() {
    super.initState();
    user = widget.user;

    if ((user.displaySettings!.userImage! == 'my_connections' && user.isConnected!) ||
        user.displaySettings!.userImage == 'all') {
      image = user.userImage != null ? user.userImage!.thumburl! : ImageResources.userAvatarImg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callUserDetail();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            UserCircularPictureWidget(image: image),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AutoSizeText(
                    user.fullName!,
                    softWrap: true,
                    maxLines: 1,
                    minFontSize: 15,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Image.asset(
                        ImageResources.schoolIcon,
                        color: ColorConstants.textColor3,
                        height: 13,
                        width: 13,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: AutoSizeText(
                          'JNV ${user.school!.district!}',
                          softWrap: true,
                          maxLines: 1,
                          minFontSize: 13,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: ColorConstants.textColor3,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Image.asset(
                        ImageResources.jnvRelationIcon,
                        color: ColorConstants.textColor3,
                        height: 13,
                        width: 13,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        user.relationWithJnv!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            actionWidget(),
          ],
        ),
      ),
    );
  }

  void callUserDetail() async {
    final userDetail = await Navigator.of(context).pushNamed(RouteGenerator.userDetailPage,
        arguments: {
          ValueKeyResources.userDataKey: user,
          ValueKeyResources.nearByDistanceKey: false
        }) as Map<String, dynamic>?;

    if (userDetail != null) {
      if (userDetail.containsKey(ValueKeyResources.userDataKey)) {
        user = userDetail[ValueKeyResources.userDataKey];
        logger.i('the data is ${user.isConnected}');

        if (!mounted) return;
        if (widget.connectionsType == ConnectionsType.connectionsSent &&
            (!user.isRequestSent! || userDetail[ValueKeyResources.userIsBlocked])) {
          context.read<ConnectionSentCubit>().loadUsers(update: true);
        } else if (widget.connectionsType == ConnectionsType.connectionsReceived &&
            (!user.isRequestReceived! || userDetail[ValueKeyResources.userIsBlocked])) {
          context.read<ConnectionReceivedCubit>().loadUsers(update: true);
        } else if (widget.connectionsType == ConnectionsType.myConnections &&
            (!user.isConnected! || userDetail[ValueKeyResources.userIsBlocked])) {
          context.read<MyConnectionsCubit>().loadUsers(update: true);
        }
      }
    }
  }

  Widget actionWidget() {
    bool isLoading = false;
    if (widget.connectionsType == ConnectionsType.myConnections) {
      return InkWell(
        onTap: () async {
          final result = await sl<CommonFunctions>().showConfirmationDialog(
            context: context,
            title: StringResources.removeConnection,
            message: StringResources.connectionRemoveDescription,
            buttonPositiveText: StringResources.confirm,
            buttonNegativeText: StringResources.cancel,
          );
          if (!mounted) return;
          if (result) {
            isLoading = true;
            context.read<MyConnectionsCubit>().removeMyConnection(user.id!);
          }
        },
        child: BlocBuilder<MyConnectionsCubit, MyConnectionsState>(
          builder: (_, state) {
            if (state is RemoveLoadingState && isLoading) {
              return const FittedBox(
                  alignment: Alignment.centerRight,
                  child: LoadingWidget(
                    size: 30,
                    margin: 0,
                  ));
            }

            isLoading = false;
            return Image.asset(
              ImageResources.cancelIcon,
              height: 35,
              width: 35,
            );
          },
        ),
      );
    } else if (widget.connectionsType == ConnectionsType.connectionsReceived) {
      return BlocBuilder<ConnectionReceivedCubit, ConnectionReceivedState>(
        builder: (_, state) {
          if (state is UpdateConnectionLoadingState && isLoading) {
            return const LoadingWidget(
              size: 35,
            );
          }
          isLoading = false;
          return Row(
            children: [
              InkWell(
                onTap: () {
                  isLoading = true;
                  context.read<ConnectionReceivedCubit>().updateConnection('accept', user.id!);
                },
                child: Image.asset(
                  ImageResources.acceptIcon,
                  height: 35,
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  isLoading = true;
                  context.read<ConnectionReceivedCubit>().updateConnection('cancel', user.id!);
                },
                child: Image.asset(
                  ImageResources.cancelIcon,
                  height: 35,
                  width: 35,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return BlocBuilder<ConnectionSentCubit, ConnectionSentState>(
        builder: (_, state) {
          if (state is UpdateConnectionSentLoadingState && isLoading) {
            return const FittedBox(
                alignment: Alignment.centerRight,
                child: LoadingWidget(
                  size: 30,
                  margin: 0,
                ));
          }
          isLoading = false;
          return InkWell(
            onTap: () {
              isLoading = true;
              context.read<ConnectionSentCubit>().updateConnection(user.id!);
            },
            child: Image.asset(
              ImageResources.cancelIcon,
              height: 35,
              width: 35,
            ),
          );
        },
      );
    }
  }
}
