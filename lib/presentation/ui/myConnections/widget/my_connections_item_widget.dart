import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/user_circular_picture_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionReceivedCubit/connection_received_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionSentCubit/connection_sent_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/myConnectionsCubit/my_connections_cubit.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';
import '../../../../core/route_generator.dart';
import '../../../basicWidget/loading_widget.dart';

enum ConnectionsType { myConnections, connectionsReceived, connectionsSent }

class MyConnectionsItemWidget extends StatelessWidget {
  final ConnectionsType connectionsType;
  final UserDataModel user;

  const MyConnectionsItemWidget({required this.user, required this.connectionsType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = ImageResources.userAvatarImg;
    if (user.displaySettings != null) {
      if (user.displaySettings!.userImage == 'all' ||
          (user.isConnected! && user.displaySettings!.userImage == 'my_connections')) {
        image = user.userImage != null ? user.userImage!.filepath! : ImageResources.userAvatarImg;
      }
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.userDetailPage, arguments: user);
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
                  Text(
                    user.fullName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.school,
                        color: ColorConstants.textColor3,
                        size: 14,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user.school!.city!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.link,
                        color: ColorConstants.textColor3,
                        size: 14,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user.relationWithJnv!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            actionWidget(context),
          ],
        ),
      ),
    );
  }

  Widget actionWidget(BuildContext context) {
    bool isLoading = false;
    if (connectionsType == ConnectionsType.myConnections) {
      return InkWell(
        onTap: () {
          isLoading = true;
          context.read<MyConnectionsCubit>().removeMyConnection(user.id!);
        },
        child: BlocBuilder<MyConnectionsCubit, MyConnectionsState>(
          builder: (_, state) {
            if (state is RemoveLoadingState && isLoading) {
              return const LoadingWidget();
            }
            isLoading = false;
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorConstants.red),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text(
                StringResources.remove,
                style: TextStyle(color: ColorConstants.red, fontSize: 12),
              ),
            );
          },
        ),
      );
    } else if (connectionsType == ConnectionsType.connectionsReceived) {
      return BlocBuilder<ConnectionReceivedCubit, ConnectionReceivedState>(
        builder: (_, state) {
          if (state is UpdateConnectionLoadingState && isLoading) {
            return const LoadingWidget();
          }

          isLoading = false;
          return Row(
            children: [
              InkWell(
                onTap: () {
                  isLoading = true;
                  context.read<ConnectionReceivedCubit>().updateConnection('cancel', user.id!);
                },
                child: Image.asset(
                  ImageResources.cancelIcon,
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  isLoading = true;
                  context.read<ConnectionReceivedCubit>().updateConnection('accept', user.id!);
                },
                child: Image.asset(
                  ImageResources.acceptIcon,
                  height: 25,
                  width: 25,
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
            return const LoadingWidget();
          }
          isLoading = false;
          return InkWell(
            onTap: () {
              isLoading = true;
              context.read<ConnectionSentCubit>().updateConnection(user.id!);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorConstants.red),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text(
                StringResources.cancel,
                style: TextStyle(color: ColorConstants.red, fontSize: 12),
              ),
            ),
          );
        },
      );
    }
  }
}
